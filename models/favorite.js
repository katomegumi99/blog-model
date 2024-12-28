const {query} = require('./db');
const { addFavoriteCount, reduceFavoriteCount} = require('./article');

async function exitsFavorite(postId, userId) {
    const sql = 'select * from favorites where post_id = ? and user_id = ?';
    const result = await query(sql, [postId, userId]);
    if (result && result.length > 0) {
        return true;
    }
    return false;
}

async function addFavorite(postId, userId) {
    const sql = 'insert into favorites (post_id, user_id) values (?,?)';
    const result = await query(sql, [postId, userId]);
    if (result.affectedRows > 0) {
        await addFavoriteCount(postId);
    }
    return result;
}

async function deleteFavorite(postId, userId) {
    const sql = 'delete from favorites where post_id = ? and user_id = ?';
    const result = await query(sql, [postId, userId]);
    if (result.affectedRows > 0) {
        await reduceFavoriteCount(postId);
    }
    return result;
}

module.exports = {
    exitsFavorite,
    addFavorite,
    deleteFavorite,
};