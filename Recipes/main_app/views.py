from django.shortcuts import render, redirect

from Recipes.main_app.forms import RecipeForm
from Recipes.main_app.models import Recipe


def index(request):
    recipes = Recipe.objects.all()
    context = {'recipes': recipes}
    return render(request, 'index.html', context)


def create(request):
    template = 'create.html'
    if request.method == 'GET':
        form = RecipeForm()
        return show_form(request, form, template)
    form = RecipeForm(request.POST)
    return save_recipe_from_form(request, form, template)


def edit(request, pk):
    recipe = Recipe.objects.get(pk=pk)
    template = 'edit.html'
    if request.method == 'GET':
        form = RecipeForm(instance=recipe)
        return show_form(request, form, template)
    form = RecipeForm(request.POST, instance=recipe)
    return save_recipe_from_form(request, form, template)


def delete(request, pk):
    recipe = Recipe.objects.get(pk=pk)
    template = 'delete.html'
    if request.method == 'GET':
        form = RecipeForm(instance=recipe)
        for name, field in form.fields.items():
            field.widget.attrs['disabled'] = True
        form.save(commit=False)
        return show_form(request, form, template)
    recipe.delete()
    return redirect(index)


def details(request, pk):
    recipe = Recipe.objects.get(pk=pk)
    ingredients_list = recipe.ingredients.split(', ')
    context = {
        'recipe': recipe,
        'list': ingredients_list,
    }
    return render(request, 'details.html', context)


def show_form(request, form, template):
    context = {'form': form}
    return render(request, template, context)


def save_recipe_from_form(request, form, template):
    if form.is_valid():
        form.save()
        return redirect(index)
    return show_form(request, form, template)