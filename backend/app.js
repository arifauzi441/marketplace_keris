var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var cors = require(`cors`)
require(`dotenv`).config()
var {connectDB} = require(`./config/db`)

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var authRouter = require(`./routes/auth`)
var productRouter = require(`./routes/product`)

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

const allowedOrigins = ['https://toko.kerissumenep.com'];

app.use(cors({
  origin: function (origin, callback) {
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  }
}))
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

(async () => {
  await connectDB()
})()

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use(`/auth`, authRouter)
app.use(`/product`, productRouter)

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  console.log(err)
  res.json({msg: err})
});

module.exports = app;
