# Домашнее задание к занятию `«Безопасность в облачных провайдерах»` - Пугач Евгений.


---

## `Задание 1. Yandex Cloud`

1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:
- создать ключ в KMS;
- с помощью ключа зашифровать содержимое бакета, созданного ранее.

### Ответ:

### `Terraform apply`

![Скриншот 1](https://github.com/PugachEV72/Images/blob/master/2024-05-25_21-09-16.png)

### `Созданные ресурсы`

![Скриншот 2](https://github.com/PugachEV72/Images/blob/master/2024-05-25_21-12-11.png)

### `Создание ключа в KMS`

[bucket.tf](https://github.com/PugachEV72/clopro-homeworks-15.3/blob/main/terraform_vms/bucket.tf)

### `Ключ шифрования`

![Скриншот 3](https://github.com/PugachEV72/Images/blob/master/2024-05-25_21-10-29.png)

![Скриншот 4](https://github.com/PugachEV72/Images/blob/master/2024-05-25_21-11-16.png)

### `Тестовое изображение`

![Скриншот 5](https://github.com/PugachEV72/Images/blob/master/2024-05-25_21-09-52.png)

---

### `Общая конфигурация`

[Terraform](https://github.com/PugachEV72/clopro-homeworks-15.3/tree/main/terraform_vms)

---

2. (Выполняется не в Terraform)* Создать статический сайт в Object Storage c собственным публичным адресом  
   и сделать доступным по HTTPS.

---

