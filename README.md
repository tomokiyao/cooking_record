# README

## SetUp

* 下記を順に実行してください。

```
$ docker-compose build
```
```
$ docker-compose run --rm app bash -c "bundle exec rails db:create db:migrate"
```
```
$ docker-compose run --rm app bash -c "yarn install"
```
```
$ docker-compose up
```

## 画面URL

* 料理記録画面

　http://localhost:3000/my_cookings
 
* レシピ画面

　http://localhost:3000/recipes
