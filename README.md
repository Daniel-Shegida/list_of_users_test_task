# Simple Test Task

## Comments to implementation (anything that you think matters)
### apk
Хранится в папке apk

### Questions 
Если это было бы не тестовое задание, я бы для начала задал бы ряд вопросов к таске, а почему я их не задал, можете узнать у меня на интервью :)
+ Я не нашел у гитхаба запросы, которые бы включали бы в себя получение списка пользователей с именами(не логинами) и фоловерами, их нет ни в graphql ни в rest api, возможно кто то знает, как обойти эту проблему?
+ в таске это не указано, но нужно ли добавлять пагинацию
+ дополнительно, нет дизайна состояния загрузок, их можно сделать на свой вкус?
+ В дизайне нарисована поисковая строка, но не совсем ясно, относится ли фича “Users of the app can filter Github users by nickname.” к ней, т.к пользователи уже могут фильтровать пользователей по первым буквам
+ Если поиск нужно сделать, какая у него должна быть логика: Производить поиск из api гитхаба или только по уже загруженным пользователям
+ Нужно ли добавлять в каком либо виде обработку ошибок: снекбары, новые состояния экраном и тд
+ В обычном состоянии, api github поддерживает до 60 запросов в час для неавторизированных пользователей, нужно ли их авторизировать?

### Main idea
С учетом того, что у gitgub api не было нужных запросов, которые сразу бы вернули нужные данные, было решено сделать следующие:
  + сначала получаем список пользотелей
  + потом для каждого пользователя запрашиваем отдельно всю нужную информацию

### Extra 
[Я сделал пр](https://github.com/Daniel-Shegida/list_of_users_test_task/pull/1), в котором есть вся задача, если не сложно, можно добавить комментарии относительно того как можно было бы сделать лучше 
### Startup
единственное, что необходимо, это добавить в .env personal access token  

### Difficults: 
+ На данный момент, загрузки новых страниц слишком долгие. Это можно решить уменьшив размер страниц, добавив загрузку страниц перед тем, как пользователь долистает до конца

+ Не уверен, что на всех экранах будет смотреться нормально, можно добавить адаптивную верстку или screenUtils

### Результат: 
Первая загрузка

![startup ](https://github.com/Daniel-Shegida/list_of_users_test_task/assets/47796424/6759209e-1e3f-473f-bc24-47ee8a73517b)

Функционал фильтрации: 

![filter](https://github.com/Daniel-Shegida/list_of_users_test_task/assets/47796424/18df5024-799b-401e-80f9-74a0c28e4535)

Функционал поиска 

![search](https://github.com/Daniel-Shegida/list_of_users_test_task/assets/47796424/65e06cf2-b2ff-42ec-9359-1e64b76e5902)
