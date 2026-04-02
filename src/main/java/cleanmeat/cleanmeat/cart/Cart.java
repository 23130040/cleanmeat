package cleanmeat.cleanmeat.cart;

import cleanmeat.cleanmeat.model.Item;
import cleanmeat.cleanmeat.model.User;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class Cart implements Serializable {
    private Map<String, CartItem> map;

    public Cart() {
        this.map = new HashMap<String, CartItem>();
    }

    private String getCompositeKey(int itemId, int weight) {
        return itemId + "_" + weight;
    }

    public void addCartItem(CartItem cartItem) {
        String key = getCompositeKey(cartItem.getId(), cartItem.getWeight());
        if (!map.containsKey(key)) {
            map.put(key, cartItem);
        } else {
            CartItem existing = map.get(key);
            existing.setQuantity(existing.getQuantity() + cartItem.getQuantity());
        }
    }

    public boolean removeCartItem(int id, int weight) {
        return map.remove(getCompositeKey(id, weight)) != null;
    }

    @Deprecated
    public boolean removeCartItem(int id) {
        for (String key : map.keySet()) {
            if (key.startsWith(id + "_")) {
                return map.remove(key) != null;
            }
        }
        return false;
    }

    public double getTotal() {
        double total = 0;
        for (CartItem cartItem : map.values()) {
            total += cartItem.getSubTotal();
        }
        return total;
    }

    public int getTotalQuantity() {
        int total = 0;
        for (CartItem item : map.values()) {
            total += item.getQuantity();
        }
        return total;
    }

    public Collection<CartItem> getList() {
        return map.values();
    }

    public void updateQuantity(int id, int weight, int quantity) {
        CartItem item = map.get(getCompositeKey(id, weight));
        if (item != null) {
            item.setQuantity(quantity);
        }
    }

    public void updateWeight(int id, int oldWeight, int newWeight) {
        String oldKey = getCompositeKey(id, oldWeight);
        String newKey = getCompositeKey(id, newWeight);
        
        CartItem item = map.get(oldKey);
        if (item == null) return;

        if (map.containsKey(newKey)) {
            CartItem existing = map.get(newKey);
            existing.setQuantity(existing.getQuantity() + item.getQuantity());
            map.remove(oldKey);
        } else {
            item.setWeight(newWeight);
            map.remove(oldKey);
            map.put(newKey, item);
        }
    }

    @Deprecated
    public void updateQuantity(int id, int quantity) {
        for (String key : map.keySet()) {
            if (key.startsWith(id + "_")) {
                map.get(key).setQuantity(quantity);
                return;
            }
        }
    }

    public void clear() {
        map.clear();
    }

}
