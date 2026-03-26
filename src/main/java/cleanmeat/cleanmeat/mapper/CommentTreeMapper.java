package cleanmeat.cleanmeat.mapper;

import cleanmeat.cleanmeat.model.CommentTree;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CommentTreeMapper {
    public static CommentTree map(ResultSet rs) throws SQLException {
        CommentTree commentTree = new CommentTree();
        commentTree.setAncestor_id(rs.getInt("ancestor_id"));
        commentTree.setDescendant_id(rs.getInt("descendant_id"));
        commentTree.setDepth(rs.getInt("depth"));
        return commentTree;
    }
}
