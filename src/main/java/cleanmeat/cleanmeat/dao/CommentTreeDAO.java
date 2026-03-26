package cleanmeat.cleanmeat.dao;

import java.util.List;

public interface CommentTreeDAO {
    public void insertRelation(int ancestor_id, int descendant_id, int depth);

    public List<Integer> findDescendantIds(int ancestor_id);

    public List<Integer> findDirectChildrenIds(int ancestor_id);

    public List<Integer> findAncestorIds(int descendant_id);

    public boolean deleteByDescendant(int descendant_id);

    public boolean deleteSubtree(int ancestor_id);
}
