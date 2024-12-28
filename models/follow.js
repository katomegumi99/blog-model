const { query } = require('./db');

// 关注
async function follow(userId, followId) {
    const sql = 'insert into follows (user_id, follower_id) values(?, ?)';
    const param = [userId, followId];
    const result = await query(sql, param);
    return result.insertId;
}

// 取消关注
async function unfollow(userId, followId) {
    const sql = 'delete from follows where user_id = ? and follower_id = ?';
    const param = [userId, followId];
    const result = await query(sql, param);
    return result.affectedRows;
}

// 获取关注列表
async function getFollowers(userId) {
    const sql = 'select * from users where id in (select follower_id from follows where user_id = ?)';
    const param = [userId];
    const result = await query(sql, param);
    return result;
}

async function getFollowings(userId) {
    const sql = 'select * from users where id in (select user_id from follows where follower_id = ?)';
    const param = [userId];
    const result = await query(sql, param);
    return result;
}

module.exports = {
    follow,
    unfollow,
    getFollowers,
    getFollowings
};