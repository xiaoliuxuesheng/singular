# RequestCache

- RequestCache获取之前的跳转的链,必须设置session的缓存机制，不能将缓存设置为none。

  ```java
  RequestCache requestCache = new HttpSessionRequestCache();
  
  SavedRequest savedRequest = requestCache.getRequest(request, response);
  
  String target = savedRequest.getRedirectUrl();
  ```

- yml配置

  ```
  spring: 
    session:
      store-type: redis
      timeout: 60
  ```

# OncePerRequestFilter

- OncePerRequestFilter，它能够确保在一次请求中只通过一次filter，而需要重复的执行。大家常识上都认为，一次请求本来就只filter一次，为什么还要由此特别限定呢，往往我们的常识和实际的实现并不真的一样，经过一番资料的查阅，此方法是为了兼容不同的web container，也就是说并不是所有的container都入我们期望的只过滤一次，servlet版本不同，执行过程也不同，
  - 在servlet2.3中，Filter会经过一切请求，包括服务器内部使用的forward转发请求和<%@ include file=”/login.jsp”%>的情况
  - servlet2.4中的Filter默认情况下只过滤外部提交的请求，forward和include这些内部转发都不会被过滤，

- 因此，为了兼容各种不同运行环境和版本，默认filter继承OncePerRequestFilter是一个比较稳妥的选择

