# devops-netology
Домашние задания по курсу Dev-Ops

------

# Домашнее задание к занятию "7.6. Написание собственных провайдеров для Terraform."


## Задача 1


Давайте потренируемся читать исходный код AWS провайдера, который можно склонировать от сюда:
[https://github.com/hashicorp/terraform-provider-aws.git](https://github.com/hashicorp/terraform-provider-aws.git).
Просто найдите нужные ресурсы в исходном коде и ответы на вопросы станут понятны.  


1. Найдите, где перечислены все доступные `resource` и `data_source`, приложите ссылку на эти строки в коде на
гитхабе.   

[`все доступные resource`](https://github.com/hashicorp/terraform-provider-aws/blob/5539af2626e1bacea60460b75f5b0ca606178700/internal/provider/provider.go#L920)

[`все доступные data_source`](https://github.com/hashicorp/terraform-provider-aws/blob/5539af2626e1bacea60460b75f5b0ca606178700/internal/provider/provider.go#L426)

1. Для создания очереди сообщений SQS используется ресурс `aws_sqs_queue` у которого есть параметр `name`.
    
   * С каким другим параметром конфликтует `name`? Приложите строчку кода, в которой это указано.

```
"name": {
			Type:          schema.TypeString,
			Optional:      true,
			Computed:      true,
			ForceNew:      true,
			ConflictsWith: []string{"name_prefix"},
```

   * Какая максимальная длина имени?

```
if len(value) > 80 {
		errors = append(errors, fmt.Errorf("%q cannot be longer than 80 characters", k))
	}
```

   * Какому регулярному выражению должно подчиняться имя?

```
if !regexp.MustCompile(`^[0-9A-Za-z-_]+(\.fifo)?$`).MatchString(value) {
  errors = append(errors, fmt.Errorf("only alphanumeric characters and hyphens allowed in %q", k))
}
```
