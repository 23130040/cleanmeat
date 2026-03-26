package cleanmeat.cleanmeat.model;

import java.io.Serializable;

public class CommentTree implements Serializable {
    private int ancestor_id;
    private int descendant_id;
    private int depth;

    public CommentTree() {}

    public CommentTree(int ancestor_id, int descendant_id, int depth) {
        this.ancestor_id = ancestor_id;
        this.descendant_id = descendant_id;
        this.depth = depth;
    }

    public int getAncestor_id() {
        return ancestor_id;
    }

    public void setAncestor_id(int ancestor_id) {
        this.ancestor_id = ancestor_id;
    }

    public int getDescendant_id() {
        return descendant_id;
    }

    public void setDescendant_id(int descendant_id) {
        this.descendant_id = descendant_id;
    }

    public int getDepth() {
        return depth;
    }

    public void setDepth(int depth) {
        this.depth = depth;
    }
}
