---
title: "Readme"
weight: 1
---

## Добавление страниц

Для того чтобы добавить страницу, необходимо написать `.md` файл, и в заголовке указать:

```
---
title: <title>
weight: <weight>
---
```

Затем добавляем его в папку `content` и сохраняем изменения

## Возможные поля в заголовке `.md` файла

**title**: Заголовок страницы или поста.

```yaml
title: "Название вашей статьи"
```
**date**: Дата публикации.

```yaml
date: 2024-06-18T10:00:00Z
```

**author**: Автор статьи.

```yaml
author: "Имя автора"
```

**description**: Краткое описание или аннотация к статье.

```yaml
description: "Краткое описание содержания статьи."
```

**tags**: Теги для организации и фильтрации контента.

```yaml
tags:
- тег1
- тег2
```

**categories**: Категории для классификации контента.

```yaml
categories:
- категория1
- категория2
```

**draft**: Указывает, является ли статья черновиком.

```yaml
draft: true
```

**slug**: Короткий URL или слаг для страницы.

```yaml
slug: "korotkiy-url"
```

**url**: Полный URL для страницы, если он отличается от автоматически сгенерированного.

```yaml
url: "/special/path/to/page/"
```

**aliases**: Альтернативные URL для перенаправлений.

```yaml
aliases:
- /old-path/
- /another-old-path/
```

**summary**: Краткое резюме статьи.

```yaml
summary: "Краткое резюме статьи для превью."
```

**keywords**: Ключевые слова для SEO.

```yaml
keywords:
- keyword1
- keyword2
```

**thumbnail**: URL изображения для превью.

```yaml
thumbnail: "/images/preview.png"
```

**featured**: Указывает, является ли статья "избранной".

```yaml
featured: true
```

**toc**: Включить или отключить содержание (table of contents) на странице.

```yaml
toc: true
```

**weight**: Порядок сортировки страницы (меньше значение - выше в списке).

```yaml
weight: 10
```

### Пример заголовка

```yaml
---
title: "Пример статьи"
date: 2024-06-18T10:00:00Z
author: "Иван Иванов"
description: "Это пример статьи для Hugo."
tags:
- пример
- hugo
categories:
- разработка
- блог
draft: false
slug: "primer-stati"
url: "/primer/stati/"
aliases:
- /old/path/
summary: "Краткое резюме статьи."
keywords:
- hugo
- markdown
thumbnail: "/images/preview.png"
featured: true
toc: true
weight: 5
---
```

## Стили

Для изменения стилей можно использовать три способа:

1) Изменение стандартных переменных стилей (пример /docs/assets/scss/_variables_project.scss) 
   - Больше переменных в доке hugo
2) Написание собственных стилей и их применение (подробнее ниже)
3) Использование стандартных средств **markdown**

### Собственные стили в hugo

#### Файл стилей

Для начала необходимо указать hugo, что у нас есть файл с кастомным css'ом. Для этого необходимо в `hugo.toml|yaml|yml` указать:

```yaml
[params]
  customCSS = ["css/custom.css"]
```

Где `css/custom.css` путь до файла с нашим кастомным css

#### Использование стилей

Для того чтобы применить к чему-либо css класс, нужно просто завернуть это в `.md` файле страницы в `<div>` с классом:

```yaml
<div class="content">
There should be whitespace between paragraphs. Vape migas chillwave sriracha poutine try-hard distillery. 
</div>
```

#### Импорт шрифтов

##### Использование Google Fonts

Самый простой способ добавить шрифты — использовать Google Fonts.

1) Перейдите на Google Fonts.
2) Выберите нужные шрифты и стили.
3) Скопируйте предоставленный код для вставки в HTML.

Добавьте этот код в файл layouts/_default/baseof.html или в любой другой файл шаблона.

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{{ .Title }}</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="{{ "css/style.css" | relURL }}">
</head>
<body>
    {{ block "main" . }}{{ end }}
</body>
</html>
```

Готово, можно использовать импортированные шрифты в css классах

##### Локальное использование шрифтов
Вы также можете скачать шрифты и хранить их локально в вашем проекте.

1) Скачайте шрифты и поместите их в папку static/fonts.
2) Создайте файл CSS (например, css/fonts.css) и подключите шрифты:

```css
@font-face {
    font-family: 'MyFont';
    src: url('../fonts/MyFont-Regular.woff2') format('woff2'),
    url('../fonts/MyFont-Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'MyFont';
    src: url('../fonts/MyFont-Bold.woff2') format('woff2'),
    url('../fonts/MyFont-Bold.woff') format('woff');
    font-weight: bold;
    font-style: normal;
}
```

3) Подключите этот файл в вашем шаблоне:

```html
<link rel="stylesheet" href="{{ "css/fonts.css" | relURL }}">
<link rel="stylesheet" href="{{ "css/style.css" | relURL }}">
```

## Пример страницы

Пример страницы можно посмотреть во вкладке [Example Page](/docs/release/example-page/) и в файле `content/en/docs/Release/example-page.md`
