const { query } = require('./db');

async function addComment(comment) {
    const sql = 'INSERT INTO comments SET?';
    const result = await query(sql, comment);
    return result.insertId;
}

async function getCommentsByArticleId(articleId) {
    const sql = `SELECT c.id AS comment_id,
            c.comment AS comment_content,
            c.created_at AS comment_created_at,
            u.id AS user_id,
            u.username AS author_username,
            u.email AS author_email
       FROM comments c
    JOIN users u ON c.user_id = u.id
    WHERE c.post_id = ?`;
    const result = await query(sql, [articleId]);
    return result;
}

module.exports = {
    addComment,
    getCommentsByArticleId,
};