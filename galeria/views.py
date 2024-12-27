from django.shortcuts import render

def index(request):
    return render(request, 'galeria/index.html')

def dicas(request):
    return render(request, 'galeria/dicas.html')

def contato(request):
    return render(request, 'galeria/contato.html')

def blog(request):
    return render(request, 'galeria/blog.html')
