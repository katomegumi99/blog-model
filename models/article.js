const { query } = require('./db')

async function getTags() {
    const sql = `SELECT * FROM tags`
    const result = await query(sql)
    return result
}

async function getArticleList(page, pageSize, id) {
    var sql = `SELECT * FROM posts LIMIT ? , ? `
    var params = [(page - 1) * pageSize, pageSize - 0]
    if (id) {
        sql = 'select * from posts where posts.id in (select post_id from post_tags where post_tags.tag_id = ? ) '
        params = [id - 0]
    }
    console.log(sql, params)
    const result = await query(sql, params)
    console.log(result)
    return result
}

async function getMyArticleList(user_id, page, pageSize) {
    const sql = `SELECT * FROM posts WHERE user_id = ? LIMIT ? , ? `
    const params = [user_id, (page - 1) * pageSize, pageSize - 0]
    const result = await query(sql, params)
    return result
}

async function getArticleById(id) {
    const sql = `SELECT * FROM posts WHERE id =?`
    const params = [id]
    const result = await query(sql, params)
    return result[0]
}
function truncateString(str, maxLength = 50) {
    // 如果字符串长度小于或等于最大长度，则直接返回原字符串
    if (str.length <= maxLength) {
        return str;
    }
    // 截取前 maxLength 个字符，并在末尾加上 '...'
    return str.slice(0, maxLength) + '...';
}

async function createArticle(article) {
    const sql = `INSERT INTO posts (user_id, title, summary, content) VALUES (?,?,?,?)`
    const params = [article.user_id, article.title, truncateString(article.content), article.content]
    const result = await query(sql, params)
    return result.insertId
}

async function updateArticle(id, title, content) {
    const sql = `UPDATE posts SET title =?, content =? WHERE id =?`
    const params = [title, content, id]
    const result = await query(sql, params)
    return result.affectedRows
}

async function deleteArticle(id) {
    const sql = `DELETE FROM posts WHERE id =?`
    const params = [id]
    const result = await query(sql, params)
    return result.affectedRows
}

async function addLikeCount(postId) {
    const sql = 'UPDATE posts SET likes_count = likes_count + 1 WHERE id =?';
    const params = [postId];
    const result = await query(sql, params);
    return result.affectedRows;
}

async function reduceLikeCount(postId) {
    const sql = 'UPDATE posts SET likes_count = likes_count - 1 WHERE id =?';
    const params = [postId];
    const result = await query(sql, params);
    return result.affectedRows;
}

async function addFavoriteCount(postId) {
    const sql = 'UPDATE posts SET favorites_count = favorites_count + 1 WHERE id =?';
    const params = [postId];
    const result = await query(sql, params);
    return result.affectedRows;
}

async function reduceFavoriteCount(postId) {
    const sql = 'UPDATE posts SET favorites_count = favorites_count - 1 WHERE id =?';
    const params = [postId];
    const result = await query(sql, params);
    return result.affectedRows;
}

async function getFavoriteArticleList(user_id, page, pageSize) {
    const sql = 'SELECT * FROM posts WHERE id IN (SELECT post_id FROM favorites WHERE user_id = ?) LIMIT ?, ?';
    const params = [user_id, (page - 1) * pageSize, pageSize - 0];
    const result = await query(sql, params);
    return result;
}

async function getUserIdByPostId(postId) {
    const sql = 'SELECT user_id FROM posts WHERE id = ?';
    const params = [postId];
    const result = await query(sql, params);
    return result;
}


module.exports = {
    getArticleList,
    getMyArticleList,
    getArticleById,
    createArticle,
    addLikeCount,
    reduceLikeCount,
    updateArticle,
    deleteArticle,
    getTags,
    addFavoriteCount,
    reduceFavoriteCount,
    getFavoriteArticleList,
    getUserIdByPostId
}