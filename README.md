

## 接口统一验签处理

    

```
签名字段:
payKey: 商户MD5签名密钥（平台分配）


所有接口必传参数:
sign: 签名（唯一不参与签名的字段）
```


##### 数据请求: 

* sign签名

```
"所有参数,除了sign,其它参数都参与签名"
"所有参数都按照ASCII码正序排序，按照key1=value1&key2=value2&......keyn=valuen的方式排序，得到待签名字符串"
"以上拼接的字符串，后面拼接上{payKey}后md5加密，得到sign值"
"返回数据分为content和message,content包含返回数据与跳转地址等,message只包含描述信息,只能用于显示"
```


##### 数据提交:

* post提交数据,返回json数据
* form表单post提交,跳转



##### 接收数据:

* 接受POST来的数据

* 验签

```
"所有参数,除了sign,其它参数都参与验签"
"所有参数都按照ASCII码正序排序,按照key1=value1&key2=value2&......keyn=valuen的方式排序,得到待签名字符串"
"以上拼接的字符串,后面拼接上payKey={payKey}后md5加密,得到sign值比较签名"
```

 

## 支付接口

> 网关地址: https://server.com/income/payment
> 提交方式: form表单post提交跳转

 

```
请求参数: 
p0_shopId: 商户号
p1_orderId: 商户交易号（订单号）,商户自己平台的订单号
p2_orderCommodity: 商品名称
p3_amount: 订单金额,单位元
p4_typeCode: 支付码,参考商户后台支付通道列表里面的支付码
p5_time: 请求时间
p6_ip: 提交IP地址
p7_frontUrl: 前端跳转地址
p8_notifyUrl: 异步通知地址
p9_bankCode: 银行编码 "网银必须传,扫码可不传"
p13_remark: 订单备注信息
sign: 签名（唯一不参与签名的字段,参考签名方法）
```


* 请求,参考签名方法
* 提交,参考数据提交方式


```
#返回参数
returnCode: 状态码,0-成功,其他-失败
content: 返回数据,包含跳转地址
```

 


## 短信快捷接口

> 网关地址: https://server.com/income/smsQuickPayment
> 提交方式: form表单post提交跳转

 

```
请求参数: 
p0_shopId: 商户号
p1_orderId: 商户交易号（订单号）,商户自己平台的订单号
p2_orderCommodity: 商品名称
p3_amount: 订单金额,单位元
p4_typeCode: 支付码,参考商户后台支付通道列表里面的支付码
p5_time: 请求时间
p6_ip: 提交IP地址
p7_frontUrl: 前端跳转地址
p8_notifyUrl: 异步通知地址
p10_bankType: 对私银行卡位0,对公银行看为1
p11_identityCard: 身份证号码
p12_cardNo: 银行卡号
p13_puserName: 持卡人姓名
p14_telePhone: 持卡人电话号码
sign: 签名（唯一不参与签名的字段,参考签名方法）
```


* 请求,参考签名方法
* 提交,参考数据提交方式


```
#返回参数
returnCode: 状态码,0-成功,其他-失败
content: 返回数据,包含跳转地址(没有签约的卡直接调到银联进行支付，已经签约的到签约页面输入短信即可！)
```

## 支付成功,异步通知

* 提交,使用post提交
* 接收,参考数据验签方法

```
返回参数: 
r0_requestNo: 平台订单号
r1_orderId:  商户交易号（订单号）,商户自己平台的订单号
r2_shopId: 商户编号
r3_amount: 订单金额,单位元
r4_status: 参考下面 status状态说明
r5_payTime: 成功支付的时间
r6_remark: 订单备注返回
sign 签名（唯一不参与签名的字段,参考签名方法）
```

 

 


## 订单查询接口


> 网关地址: https://server.com/income/check



```
请求参数: 
p0_shopId: 商户编号
p1_orderId: 商户交易号（订单号）,商户自己平台的订单号
sign: 签名（唯一不参与签名的字段,参考签名方法）
```


* 请求,参考签名方法
* 提交,使用post提交
* 接收,参考数据验签方法
* 成功之后商户自己业务逻辑的处理



```
返回参数: 
returnCode: 状态码,正常为0,1或其他为错误
content: 返回的数据
message: returnCode不为0时返回错误描述
sign: 签名（content中的所有数据参与验签,参考签名方法）

returnCode 为0时,content中的数据
content-->r0_requestNo: 平台订单号
content-->r1_orderId: 商户交易号（订单号）,商户自己平台的订单号
content-->r2_shopId: 商户编号
content-->r3_amount: 订单金额,单位元
content-->r4_status: 参考下面 status状态说明
content-->sign 签名（唯一不参与签名的字段,参考签名方法）
```

* status状态说明

```
send => 提出申请
s => 处理成功
fd => 申请驳回
w => 处理中
```


## 代付申请接口


> 网关地址: https://server.com/outcome/outProxy



```
请求参数: 
p0_shopId: 商户编号
p1_orderId: 商户交易号（订单号）,商户自己平台的订单号
p2_amount: 代付订单金额,单位元
p3_bankType: 对私银行卡位0,对公银行看为1
p4_cardNo: 收款人银行卡号
p5_phone: 电话号码
p6_realName: 收款人姓名
p7_identityCard: 收款人身份证
p8_bankCode: 银行编码
p9_bankClearNo: 清算银行编码,默认与银行编码一致
p10_bankBranchNo: 支行编号,请百度查询相关支行行号
p11_bankBranchName: 支行名称
p12_province: 银行卡默认所属省分
p13_city: 银行卡默认所属市区
p14_notifyUrl: 异步通知地址
p15_remark: 订单备注信息
sign: 签名（唯一不参与签名的字段,参考签名方法）
```


* 请求,参考签名方法
* 提交,参考数据提交方式


```
#返回参数
returnCode: 状态码,0-成功,其他-失败
message: 状态说明
```


## 代付查询接口


> 网关地址: https://server.com/outcome/outProxyQuery


```
请求参数: 
p0_shopId: 商户编号
p1_orderId: 商户交易号（订单号）,商户自己平台的订单号
sign: 签名（唯一不参与签名的字段,参考签名方法）
```


* 请求,参考签名方法
* 提交,使用post提交
* 接收,参考数据验签方法
* 成功之后商户自己业务逻辑的处理



```
返回参数: 
returnCode: 状态码,正常为0,1或其他错误
message: returnCode不为0时返回错误状态说明
content: 返回的数据
sign: 签名（content中的所有数据参与验签,参考签名方法）

returnCode为0时,content中的数据
content-->r0_requestNo: 平台订单号
content-->r1_orderId: 商户交易号（订单号）,商户自己平台的订单号
content-->r2_shopId: 商户编号
content-->r3_amount: 订单金额,单位元
content-->r4_status: 参考下面 status状态说明
content-->r5_msg: 代付状态中文描述
content-->sign 签名（唯一不参与签名的字段,参考签名方法）
```


## 代付处理完成,异步通知结果

```
返回参数: 
r2_shopId: 商户编号
r3_amount: 订单金额,单位元
r1_orderId: 商户交易号（订单号）,商户自己平台的订单号
r0_requestNo: 平台订单号
r4_status: 查看status状态说明
r5_payTime: 打款成功的时间
r6_remark: 订单备注返回
sign 签名（唯一不参与签名的字段,参考签名方法）
```
 


* status状态说明

```
send => 提出申请
s => 处理成功
fd => 申请驳回
w => 处理中
```

* 提交,post数据提交
* 接收,参考数据验签方法
* 返回, s 表示通知处理成功,其它表示失败



## 商户余额查询接口


> 网关地址: https://server.com/outcome/balance



```
请求参数: 
p0_shopId: 商户编号
sign: 签名（唯一不参与签名的字段,参考签名方法）
```


* 请求,参考签名方法
* 提交,使用post提交
* 接收,参考数据验签方法
* 成功之后商户自己业务逻辑的处理


```
返回参数: 
returnCode: 状态码,正常为0,1或其他错误
message: returnCode不为0时返回错误状态说明
content: 返回的数据
sign: 签名（content中的所有数据参与验签,参考签名方法）

returnCode为0时,content中的数据
content-->r0_balance: 可用金额,单位元
content-->sign 签名（唯一不参与签名的字段,参考签名方法）
```


##编码信息

* 银行编码说明

```
ICBC => 工商银行
CCB => 建设银行
ABC => 农业银行
CMB => 招商银行
BOCO=> 交通银行
BOC => 中国银行
CEB => 光大银行
CMBC => 民生银行
CIB => 兴业银行
ECITIC => 中信银行
CGB => 广发银行
SPDB => 浦发银行
BCCB => 北京银行
PINGANBANK => 平安银行
HXB => 华夏银行
SHB => 上海银行
POST => 邮储银行
```



* 支付编码列表

```
快捷D0通道编码: KD0
网银D0通道编码: BD0
支付宝H5D0通道编码: AD05
支付宝D0扫码通道编码: AD0S
微信H5D0通道编码: WD05
微信D0扫码通道编码: WD0S
```
