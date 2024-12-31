const express = require('express')
const app = express()
const jwt = require('jsonwebtoken');

app.use(express.static('public'))

app.use(express.urlencoded({ extended: true })) // 用于解析URL编码的请求体

app.use(express.json())// 用于解析JSON格式的请求体

app.get('/test', (req, res) => {
    res.redirect('/lpost.html')
})

const authenticateJWT = (req, res, next) => {
    console.log('req.path', req.path);
    if (req.path === '/auth/login') {
        return next(); // 登录接口不需要进行拦截
    }
    const token = req.header("Authorization");// 从请求头获取token
    if (token == null) {
        return res.sendStatus(401);// 如果没有token，则返回错误码401
    }

    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) {
            return res.sendStatus(403);// 如果 token 无效则返回错误码403
        }
        req.user = user;
        next();
    });
}


app.use('/api', authenticateJWT)
app.use('/api/auth', require('./routes/user'))
app.use('/api/article', require('./routes/article'))
app.use('/api/comment', require('./routes/comment'))    
app.use('/api/like', require('./routes/like'))
app.use('/api/favorite', require('./routes/favorite'))
app.use("/api/follow", require('./routes/follow'))

app.listen(3333, () => {
    console.log('Server is running on port 3333')
})
