from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('dicas/', views.dicas, name='dicas'),
    path('contato/', views.contato, name='contato'),
    path('blog/', views.blog, name='blog'),
]
