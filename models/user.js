const e = require('express');
const { query } = require('./db');
const bcrypt = require('bcryptjs');

async function getUserByEmail(email) {
    console.log('getUserByEmail', email)
    let sql = 'SELECT * FROM users WHERE email = ? ';
    let values = [email];
    try {
        let result = await query(sql, values);
        console.log('result', result)
        return { user: result[0] };
    } catch (error) {
        return { error: error };
    }
}

async function getUserById(id) {
    console.log('getUserById', id)
    let sql = 'SELECT * FROM users WHERE id = ? ';
    let values = [id];
    let result = await query(sql, values);
    console.log('result', result)
    return result[0] ;

}

async function addUser(user) {
    try {
        console.log('addUser', user)
        user.password = await bcrypt.hashSync(user.password, 10);
        let sql = 'INSERT INTO users SET ? ';
        let values = [user];
        let result = await query(sql, values);
        if (!result.insertId) {
            return { error: 'add user failed' };
        } else {
            user.id = result.insertId;
            return { user: user };
        }
    } catch (error) {
        return { error: error };
    }
}

async function login(email, password) {

    console.log('login', email, password)
    try {
        let { error, user } = await getUserByEmail(email);
        if (error) {
            return { error: error };
        }
        if (!user) {
            return { error: 'user not exist' };
        }
        const isMatch = await bcrypt.compare(password, user.password);

        if (!isMatch) {
            return { error: 'password error' };
        }
        return { user: user };
    } catch (error) {
        return { error: error };
    }
}


async function register(user) {
    console.log('register', user)
    try {
        let getUser = await getUserByEmail(user.email);
        if (getUser.error) {
            return { error: getUser.error };
        }
        if (getUser.user) {
            return { error: 'user exist' };
        }
        let result = await addUser(user);
        if (result.error) {
            return { error: result.error };
        }
        return { user: result.user };
    } catch (error) {
        return { error: error };
    }
}
//  {"username":"test", "email":"lisi@qq.com","password":"123456"}

module.exports = {
    login, register,getUserById
};