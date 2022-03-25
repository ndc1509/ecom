# Generated by Django 4.0.3 on 2022-03-23 16:20

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('items', '0004_alter_item_table'),
    ]

    operations = [
        migrations.CreateModel(
            name='Author',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='BookCategory',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('parent', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='children', to='items.bookcategory')),
            ],
        ),
        migrations.CreateModel(
            name='LaptopBrand',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('origin', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('price', models.FloatField()),
                ('stock', models.IntegerField()),
                ('sold', models.IntegerField()),
                ('status', models.CharField(choices=[('C', 'Còn hàng'), ('H', 'Hết hàng'), ('CH', 'Chờ hàng')], max_length=2)),
                ('slug', models.SlugField()),
                ('description', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='ProductImage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(upload_to='')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='items.product')),
            ],
            options={
                'verbose_name_plural': 'Product images',
            },
        ),
        migrations.CreateModel(
            name='SmartphoneBrand',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('origin', models.CharField(max_length=100)),
            ],
        ),
        migrations.DeleteModel(
            name='Item',
        ),
        migrations.CreateModel(
            name='Smartphone',
            fields=[
                ('product_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='items.product')),
                ('cpu', models.CharField(max_length=100)),
                ('ram', models.CharField(max_length=100)),
                ('rom', models.CharField(max_length=100)),
                ('camera', models.CharField(max_length=100)),
                ('display', models.CharField(max_length=100)),
                ('battery', models.CharField(max_length=100)),
                ('os', models.CharField(max_length=100)),
                ('brand', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='items.smartphonebrand')),
            ],
            bases=('items.product',),
        ),
        migrations.CreateModel(
            name='Laptop',
            fields=[
                ('product_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='items.product')),
                ('ram', models.CharField(max_length=100)),
                ('vga', models.CharField(max_length=100)),
                ('cpu', models.CharField(max_length=100)),
                ('screen', models.CharField(max_length=100)),
                ('storage', models.CharField(max_length=100)),
                ('battery', models.CharField(max_length=100)),
                ('os', models.CharField(max_length=100)),
                ('brand', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='items.laptopbrand')),
            ],
            bases=('items.product',),
        ),
        migrations.CreateModel(
            name='Book',
            fields=[
                ('product_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='items.product')),
                ('publisher', models.CharField(max_length=255)),
                ('publication_date', models.DateField(blank=True, null=True)),
                ('numbers_of_pages', models.IntegerField()),
                ('author', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='items.author')),
            ],
            bases=('items.product',),
        ),
    ]
