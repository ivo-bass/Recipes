#! /bin/sh

echo "
Hello to Django Project-Maker 1.0

"

# shellcheck disable=SC2039
echo -e "\e[1;31m Write a name for main directory of your project \e[0m"
# shellcheck disable=SC2162
read dirname
mkdir "$dirname"
echo "
Directory '$dirname' was created!
"
# shellcheck disable=SC2164
cd "$dirname"

echo "
Creating virtual environment 'venv'...
"
python3 -m venv venv
echo "Done"

# shellcheck disable=SC2039
source venv/bin/activate
echo "
Venv is activated!
"

echo "
Upgrading pip...
"
python3 -m pip install --upgrade pip

echo "
Installing Django...
"
python3 -m pip install django

echo " "
# shellcheck disable=SC2039
echo -e "
\e[1;31m Write name for your project \e[0m"
# shellcheck disable=SC2162
read projectname
echo "
Creating $projectname Django project...
"
django-admin startproject "$projectname" .
echo "
Project '$projectname' is created!
"

mkdir ./templates
echo "
Templates dir made.
"

mkdir ./static
echo "
Static dir made.
"

cp ../exam_project_creator.sh ./exam_project_creator.sh

echo " "
# shellcheck disable=SC2039
echo -e "
\e[1;31m Write name for your first app \e[0m"
# shellcheck disable=SC2162
read firstapp

echo "
Creating '$firstapp' app INSIDE '$projectname' directory...
"
python3 manage.py startapp "$firstapp"


mkdir ./Tests
mkdir ./Tests/"$firstapp"
# shellcheck disable=SC2086
touch ./Tests/$firstapp/__init__.py

mkdir ./Tests/"$firstapp"/views
touch ./Tests/"$firstapp"/views/__init__.py
echo "from django.test import TestCase, Client


# TestsClass here
" >> ./Tests/"$firstapp"/views/test_index.py

echo "from django.test import TestCase, Client


# TestsClass here
" >> ./Tests/"$firstapp"/views/test_create.py

echo "from django.test import TestCase, Client


# TestsClass here
" >> ./Tests/"$firstapp"/views/test_edit.py

echo "from django.test import TestCase, Client


# TestsClass here
" >> ./Tests/"$firstapp"/views/test_delete.py

mkdir ./Tests/"$firstapp"/validators
touch ./Tests/"$firstapp"/validators/__init__.py
echo "from django.test import TestCase


# TestsClass here
" >> ./Tests/"$firstapp"/validators/test_validatorname.py

mkdir ./Tests/"$firstapp"/forms
touch ./Tests/"$firstapp"/forms/__init__.py
echo "from django.test import TestCase


# TestsClass here
" >> ./Tests/"$firstapp"/forms/test_formname.py

mkdir ./Tests/"$firstapp"/models
touch ./Tests/"$firstapp"/models/__init__.py
# shellcheck disable=SC2129
echo"from django.test import TestCase


# If the model has a from => test the form only
# TestsClass here
" >> ./Tests/"$firstapp"/models/test_modelname.py


# shellcheck disable=SC2039
echo -e "
\e[1;31m Added Tests dir with test files \e[0m
"

echo "
Added STATICFILES_DIRS to settings.py
"
echo "

STATICFILES_DIRS = [BASE_DIR / 'static']
" >> ./$projectname/settings.py


echo "Starting initial migrations..."
python3 manage.py makemigrations
python3 manage.py migrate
echo "Done"

# shellcheck disable=SC2039
echo -e "\e[1;31m Creating .gitignore... \e[0m"
# shellcheck disable=SC2129
echo "venv" >> .gitignore
echo ".vscode" >> .gitignore
echo ".idea/" >> .gitignore
echo "__pycache__" >> .gitignore

# shellcheck disable=SC2039
echo -e "\e[1;31m Creating README... \e[0m"
# shellcheck disable=SC2129
echo "
# $projectname

This project is instantiated by my shell script which:
1. Creates venv
2. Installs Django
3. Starts project
4. Creates app OUTSIDE the project
5. Creates .gitignore
6. Creates README
7. Creates requirements
8. Creates local git repo, adds all and does init commit
9. Makes 'templates' dir
10. Adds Tests Skeleton
11. Added STATICFILES_DIRS to settings.py

!!! I NEED TO MAKE THE FOLLOWING CHANGES AFTER OPENING PYCHARM:
1. Edit run configuration in PyCharm - set the starting point and add the venv.
2. Move the app inside the project.
3. In settings.py you need to add     'project.appp',    to INSTALLED_APPS list.
4. Mark templates folder as templates folder

***Script by Ivailo Ignatov - IvoBass***
" >> README.md

echo "Creating requirements.txt"
python3 -m pip freeze > requirements.txt

echo "Initializing git repo..."
git init
git add .
git commit -m "initial commit"


echo "

All set!
PyCharm will open."

# shellcheck disable=SC2039
echo -e "

\e[1;31m !!! OPEN README.md TO FINALIZE SETUP !!! \e[0m
"
echo "

Hit ENTER to open project in Pycharm
"
# shellcheck disable=SC2034
# shellcheck disable=SC2162
read start

charm ../"$dirname"
