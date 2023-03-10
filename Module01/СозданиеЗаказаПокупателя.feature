#language: ru

@tree

Функционал: Создание заказа покупателя с проверкой ТЧ

Как Менеджер по продажам я хочу
зарегистрировать в системе заказ клиента
и проверить корректность заполнения ТЧ 
чтобы запланировать продажу товаров или услуг 

Контекст:
// 1С:Предприятие 8.3 (8.3.22.1750)
// Демонстрационное приложение (1.0.35.1)

Дано Я открыл новый сеанс TestClient или подключил уже существующий

Сценарий: Создание заказа покупателя с товарами
И я закрываю все окна клиентского приложения
И В командном интерфейсе я выбираю 'Продажи' 'Заказы'
Тогда открылось окно 'Заказы товаров'
И я нажимаю на кнопку с именем 'ФормаСоздать'
Тогда открылось окно 'Заказ (создание)'
* Заполнение реквизитов шапки документа
	И из выпадающего списка с именем "Организация" я выбираю точное значение 'ООО "Все для дома"'
	И я нажимаю кнопку выбора у поля с именем "Покупатель"
	Тогда открылось окно 'Контрагенты'
	И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование' |
			| '000000002' | 'Покупатели'   |
	И в таблице  "Список" я перехожу на один уровень вниз
	И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование'           |
			| '000000016' | 'Магазин "Мясная лавка"' |
	И в таблице "Список" я выбираю текущую строку
	Тогда открылось окно 'Заказ (создание) *'
	И из выпадающего списка с именем "Склад" я выбираю точное значение 'Большой'
	И из выпадающего списка с именем "ВидЦен" я выбираю точное значение 'Мелкооптовая'
	И из выпадающего списка с именем "Валюта" я выбираю точное значение 'Рубли'
* Заполнение табличной части Товары
	* Добавить товар и проверить расчет суммы при изменении цены
		И в таблице "Товары" я нажимаю на кнопку с именем 'ТоварыДобавить'
		И в таблице "Товары" я нажимаю кнопку выбора у реквизита с именем "ТоварыТовар"
		Тогда открылось окно 'Товары'
		И в таблице "Список" я перехожу к строке:
				| 'Код'       | 'Наименование' |
				| '000000011' | 'Продукты'   |
		И в таблице  "Список" я перехожу на один уровень вниз
		И в таблице "Список" я перехожу к строке:
				| 'Код'       | 'Наименование' |
				| '000000030' | 'Колбаса'      |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Заказ (создание) *'
		И в таблице "Товары" я активизирую поле с именем "ТоварыКоличество"
		И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст '10'
		И в таблице "Товары" я активизирую поле с именем "ТоварыЦена"
		И в таблице "Товары" в поле с именем 'ТоварыЦена' я ввожу текст '330,00'
		И в таблице "Товары" я завершаю редактирование строки
		//-( Без этого шага почему-то не находит таблицу Товары
		Тогда открылось окно 'Заказ (создание) *'
		//-)
		Тогда таблица "Товары" содержит строки:
				| 'Товар'    | 'Цена'   | 'Количество' | 'Сумма'    |
				| 'Колбаса ' | '330,00' | '10'         | '3 300,00' |
		Тогда элемент формы с именем "ТоварыИтогСумма" стал равен "3 300"
	* Добавить товар и проверить расчет суммы от количества
		И в таблице "Товары" я нажимаю на кнопку с именем 'ТоварыДобавить'
		И в таблице "Товары" я нажимаю кнопку выбора у реквизита с именем "ТоварыТовар"
		Тогда открылось окно 'Товары'
		И в таблице "Список" я перехожу к строке:
				| 'Код'       | 'Наименование' |
				| '000000011' | 'Продукты'   |
		И в таблице  "Список" я перехожу на один уровень вниз
		И в таблице "Список" я перехожу к строке:
				| 'Код'       | 'Наименование' |
				| '000000029' | 'Хлеб'         |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Заказ (создание) *'
		И в таблице "Товары" я активизирую поле с именем "ТоварыЦена"
		И в таблице "Товары" в поле с именем 'ТоварыЦена' я ввожу текст '30,00'
		И в таблице "Товары" я активизирую поле с именем "ТоварыКоличество"
		И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст '10'
		И в таблице "Товары" я завершаю редактирование строки
		//-( Без этого шага почему-то не находит таблицу Товары
		Тогда открылось окно 'Заказ (создание) *'
		//-)
		Тогда таблица "Товары" содержит строки:
				| 'Товар' | 'Цена'  | 'Количество' | 'Сумма'  |
				| 'Хлеб ' | '30,00' | '10'         | '300,00' |
		Тогда элемент формы с именем "ТоварыИтогСумма" стал равен "3 600"
* Записать и провести документ
	И я нажимаю на кнопку "Записать"
	И я запоминаю значение поля "Номер" как "$Номер$"
	И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
	И я жду закрытия окна 'Поступление товара (создание) *' в течение 20 секунд
	И таблица "Список" содержит строки :
		| 'Номер'   | 'Организация'        | 'Покупатель'             |
		| '$Номер$' | 'ООО "Все для дома"' | 'Магазин "Мясная лавка"' |

Сценарий: Создание заказа покупателя с услугами
И я закрываю все окна клиентского приложения
И В командном интерфейсе я выбираю 'Продажи' 'Заказы'
Тогда открылось окно 'Заказы товаров'
И я нажимаю на кнопку с именем 'ФормаСоздать'
Тогда открылось окно 'Заказ (создание)'
* Заполнение реквизитов шапки документа
	И из выпадающего списка с именем "Организация" я выбираю точное значение 'ООО "Все для дома"'
	И я нажимаю кнопку выбора у поля с именем "Покупатель"
	Тогда открылось окно 'Контрагенты'
	И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование' |
			| '000000002' | 'Покупатели'   |
	И в таблице  "Список" я перехожу на один уровень вниз
	И в таблице "Список" я перехожу к строке:
			| 'Код'       | 'Наименование'           |
			| '000000016' | 'Магазин "Мясная лавка"' |
	И в таблице "Список" я выбираю текущую строку
	Тогда открылось окно 'Заказ (создание) *'
	И из выпадающего списка с именем "Склад" я выбираю точное значение 'Большой'
	И из выпадающего списка с именем "ВидЦен" я выбираю точное значение 'Мелкооптовая'
	И из выпадающего списка с именем "Валюта" я выбираю точное значение 'Рубли'
* Заполнение табличной части Товары
	* Добавить услугу и проверить расчет суммы при изменении цены
		И в таблице "Товары" я нажимаю на кнопку с именем 'ТоварыДобавить'
		И в таблице "Товары" я нажимаю кнопку выбора у реквизита с именем "ТоварыТовар"
		Тогда открылось окно 'Товары'
		И в таблице "Список" я перехожу к строке:
				| 'Код'       | 'Наименование' |
				| '000000036' | 'Услуги'   |
		И в таблице  "Список" я перехожу на один уровень вниз
		И в таблице "Список" я перехожу к строке:
				| 'Код'       | 'Наименование' |
				| '000000037' | 'Доставка'      |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Заказ (создание) *'
		И в таблице "Товары" я активизирую поле с именем "ТоварыЦена"
		И в таблице "Товары" в поле с именем 'ТоварыЦена' я ввожу текст '250,00'
		И в таблице "Товары" я завершаю редактирование строки
		//-( Без этого шага почему-то не находит таблицу Товары
		Тогда открылось окно 'Заказ (создание) *'
		//-)
		Тогда таблица "Товары" содержит строки:
				| 'Товар'     | 'Цена'   | 'Количество' | 'Сумма'  |
				| 'Доставка ' | '250,00' | '*'          | '250,00' |
		Тогда элемент формы с именем "ТоварыИтогСумма" стал равен "250"
	* Добавить услугу с установкой количества (возможно падение)
		И в таблице "Товары" я нажимаю на кнопку с именем 'ТоварыДобавить'
		И в таблице "Товары" я нажимаю кнопку выбора у реквизита с именем "ТоварыТовар"
		Тогда открылось окно 'Товары'
		И в таблице "Список" я перехожу к строке:
				| 'Код'       | 'Наименование' |
				| '000000036' | 'Услуги'   |
		И в таблице  "Список" я перехожу на один уровень вниз
		И в таблице "Список" я перехожу к строке:
				| 'Код'       | 'Наименование' |
				| '000000037' | 'Доставка'      |
		И в таблице "Список" я выбираю текущую строку
		Тогда открылось окно 'Заказ (создание) *'
		И в таблице "Товары" я активизирую поле с именем "ТоварыЦена"
		И в таблице "Товары" в поле с именем 'ТоварыЦена' я ввожу текст '500,00'
		И в таблице "Товары" я активизирую поле с именем "ТоварыКоличество"
		И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст '10'
		И в таблице "Товары" я завершаю редактирование строки
		//-( Без этого шага почему-то не находит таблицу Товары
		Тогда открылось окно 'Заказ (создание) *'
		//-)
		Тогда таблица "Товары" содержит строки:
				| 'Товар'     | 'Цена'   | 'Количество' | 'Сумма'    |
				| 'Доставка ' | '500,00' | '10'         | '5 000,00' |
		Тогда элемент формы с именем "ТоварыИтогСумма" стал равен "5 250"
* Записать и провести документ
	И я нажимаю на кнопку "Записать"
	И я запоминаю значение поля "Номер" как "$Номер$"
	И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
	И я жду закрытия окна 'Поступление товара (создание) *' в течение 20 секунд
	И таблица "Список" содержит строки :
		| 'Номер'   | 'Организация'        | 'Покупатель'             |
		| '$Номер$' | 'ООО "Все для дома"' | 'Магазин "Мясная лавка"' |