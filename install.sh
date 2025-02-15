
### ### ### ### ### ### ###  ### ### ### ### ### ### ### ### ###  ### ### ### ### ### ### ### #  
###        INSTALL PostgreSQL                                                              ###
###  https://selectel.ru/blog/tutorials/how-to-install-and-use-postgresql-on-ubuntu-20-04/ ###  
### ### ### ### ### ### ###  ### ### ### ### ### ### ### ### ###  ### ### ### ### ### ### ### #


	printf '\n\t\t\t\033[00;34m <<<  1.  До загрузки PostgreSQL обновляем списки пакетов:   >>>\n\t\t ' 
	printf '\n\t\t\t\033[00;34m <<<  2.  Загрузим PostgreSQL с утилитой -contrib:           >>>\n\t\t ' 
	# Загрузятся драйверы PostgreSQL последней версии и развернутся необходимые компоненты на Ubuntu.
	printf '\n\t\t\t\033[00;34m <<<  3.  Запускаем сервис:                                  >>>\n\t\t '
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql.service

	printf '\n\t\t\t\033[00;34m <<<  4.  Проверка статуса сервиса:                       >>>\n\t\t ' 
sudo systemctl status postgresql.service


# Сервис развернули, теперь разберемся в работе аккаунта Postgres.

# Войдем в аккаунт Postgres с sudo. Если сейчас находимся в аккаунте Postgres, нужно выйти, набрав exit. В этом варианте перейдем в аккаунт Postgres с sudo:


# $ sudo -u postgres psql

# Возврат в аккаунт: 
# $ postgres=# \q


