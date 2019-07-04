

## API工整对接文档V2.3.1

  


##### 数据请求方式: 


* 所有参数,除了sign,其它参数都参与签名
* 所有参数都按照ASCII码正序排序，按照key1=value1&key2=value2&......keyn=valuen的方式排序，得到待签名字符串
* 以上拼接的字符串，后面拼接上{payKey}后md5加密，得到sign值
* 返回数据分为content和message,content包含返回数据与跳转地址等,message只包含描述信息,只能用于显示
* post提交数据,返回json数据
* form表单post提交,跳转


##### 数据验证规则


* 所有参数,除了sign,其它参数都参与验签
* 所有参数都按照ASCII码正序排序,按照key1=value1&key2=value2&......keyn=valuen的方式排序,得到待签名字符串
* 以上拼接的字符串,后面拼接上{payKey}后md5加密,得到sign值比较签名


 

## 支付接口

```yml 
"merchant_no": "商户号"
"order_time": "请求时间"
"order_money": "订单金额,单位元"
"product_name": "商品名称"
"pay_type_id": "支付码,参考商户后台支付通道列表里面的支付码"
"order_no": "商户交易号（订单号）,商户自己平台的订单号"
"pay_ip": "提交IP地址"
"bank_code": "银行编码 "网银必须传,扫码可不传""
"redirect_url": "前端跳转地址"
"notify_url": "异步通知地址"
"remark": "订单备注信息"
"sign": "签名"
```




>Return

```yml
"returnCode": "0==成功,其他==失败"
"content": "返回数据,包含跳转地址"
```

 

## 异步通知


```yml
"merchant_no": "商户号"
"order_time": "请求时间"
"order_money": "订单金额,单位元"
"product_name": "商品名称"
"pay_type_id": " 支付码,参考平台后台支付类型管理的支付码"
"order_no": "商户交易号（订单号）,商户自己平台的订单号"
"platformNo": "平台订单号"
"platformPayStatus": "参考下面 status状态说明"
"platformPayTime": "成功支付的时间"
"remark": "订单备注返回"
"sign": "签名""
```

 

 


## 订单查询接口



```yml
"merchant_no": "商户编号"
"order_no": "商户交易号（订单号）,商户自己平台的订单号"
"sign": "签名"
```


>Return

```yml
"returnCode": "状态码,正常为0,1或其他为错误"
"content": "返回的数据"
"message": "returnCode不为0时返回错误描述"
"sign": "签名"

"content.merchant_no": "商户编号"
"content.order_money": "订单金额,单位元"
"content.order_no": "商户交易号（订单号）,商户自己平台的订单号"
"content.platformNo": "平台订单号"
"content.platformPayStatus": "参考下面 status状态说明"
"content.sign": "签名"
```

* status状态说明

```yml
ok == 提出申请
success == 处理成功
failed == 申请驳回
waiting == 处理中
```


## 代付申请接口



```yml
"merchant_no": "商户编号"
"payee_name": "收款人姓名"
"payee_id_card": "收款人身份证"
"phone_num": "电话号码"
"payee_bank_card_no": "收款人银行卡号"
"transfer_money": "代付订单金额,单位元"
"transfer_id": "商户交易号（订单号）,商户自己平台的订单号"
"bank_code": "银行编码"
"bank_clear_no": "清算银行编码,默认与银行编码一致"
"bank_type": "对私银行卡位0,对公银行看为1"
"bank_branch_no": "支行编号,请百度查询相关支行行号"
"bank_branch_name": "支行名称"
"notify_url": "异步通知地址"
"city": "银行卡默认所属市区"
"province": "银行卡默认所属省分"
"remark": "订单备注信息"
"sign": "签名"
```



>Return

```yml
"returnCode": 状态码,0==成功,其他==失败"
"message": "状态说明"
```


## 代付查询接口


```yml
"merchant_no": "商户号"
"transfer_id": "商户交易号（订单号）,商户自己平台的订单号"
"sign": "签名"
```




>Return

```yml
"returnCode": "状态码,正常为0,1或其他错误"
"message": "returnCode不为0时返回错误状态说明"
"content": "返回的数据"
"sign": "签名"


"content.merchant_no": "商户号"
"content.transfer_money": "订单金额,单位元"
"content.transfer_id": "商户交易号（订单号）,商户自己平台的订单号"
"content.message": "代付中文描述"
"content.platformNo": "平台订单号"
"content.platformProxyStatus": "查看status状态说明"
"content.sign": "签名"
```


## 代付处理完成,异步通知结果

```yml
"merchant_no": "商户号"
"transfer_money": "订单金额,单位元"
"transfer_id": "商户交易号（订单号）,商户自己平台的订单号"
"platformNo": "平台订单号"
"platformProxyStatus": "查看status状态说明"
"platformProxyedTime": "打款成功的时间"
"remark": "订单备注返回"
"sign": "签名"
```
 


##### status状态说明

```yml
ok == 提出申请
success == 处理成功
failed == 申请驳回
waiting == 处理中
```




