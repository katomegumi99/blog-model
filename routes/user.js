const e = require('express');
const express = require('express');
const router = express.Router();
const { login, register } = require('../models/user');
const jwt = require('jsonwebtoken');

router.post('/login', async (req, res) => {
    console.log(req.body);
    let { username, password } = req.body;
    let email = username;
    try {
        let { error, user } = await login(email, password)
        console.log(user, error)
        // 生成 token
        const token = jwt.sign({ id: user.id, username: user.username, email: user.email }, process.env.JWT_SECRET, { expiresIn: '1h' });// 1h 过期时间
        if (error) {
            return res.status(201).json({
                error: error
            });
        }
        res.status(200).json({
            id: user.id,
            username: user.username,
            email: user.email,
            token
        });
    } catch (error) {
        return res.status(500).json({
            error: 'Internal Server Error'
        });
    }
});

router.post('/register', async (req, res) => {
    console.log('route register', req.body);
    try {
        let { error, user } = await register(req.body);
        console.log(user, error)
        if (error) {
            return res.status(201).json({
                error: error
            });
        }
        res.status(200).json({
            ...user
        });
    } catch (error) {
        return res.status(500).json({
            error: 'Internal Server Error'
        });
    }
});


router.get('/logout', (req, res) => {
    res.send('Hello World!');
});

module.exports = router;