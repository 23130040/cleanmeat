package cleanmeat.cleanmeat.cart;

import cleanmeat.cleanmeat.model.Item;
import cleanmeat.cleanmeat.model.User;

import java.io.Serializable;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class Cart implements Serializable {
    private Map<Integer, CartItem> map;

    public Cart() {
        this.map = new HashMap<Integer, CartItem>();
    }

    public void addCartItem(CartItem cartItem) {
        if (!map.containsKey(cartItem.getId())) {
            map.put(cartItem.getId(), cartItem);
        } else {
            CartItem existing = map.get(cartItem.getId());
            existing.setQuantity(existing.getQuantity() + cartItem.getQuantity());
        }
    }

    public boolean removeCartItem(int id) {
        return map.remove(id) != null;
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

    public void updateQuantity(int id, int quantity) {
        CartItem item = map.get(id);
        if (item != null) {
            item.setQuantity(quantity);
        }
    }

    public void clear() {
        map.clear();
    }

}
