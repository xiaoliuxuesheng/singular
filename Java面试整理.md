# 001_Java基础

# 002_JavaWEB

# 003_数据库

# 004_Spring

## 1. Spring启动流程

![image-20220529165121797](.\resource\Java面试整理\image-20220529165121797.png)

- 核心接口

  - BeanFactory
  - Aware
  - BeanDefinition
  - BeanDefinitionReader
  - BeanFactoryPostProcessor
  - BeanPostProcessor
  - Environment > StandardEnvironment
  - FactoryBean：都是用来创建对象的，当使用BeanFactory时候，创建bean遵循Bean的完成创建流程；而使用FactoryBean时整个对象的创建流程有用户自己来控制；
  - BeanDefinitionRegistry

- 源码解析

  - AbstractApplicationContext

    ```java
    public class AbstractApplicationContext{
      public void refresh() throws BeansException, IllegalStateException {
        synchronized(this.startupShutdownMonitor) {
          StartupStep contextRefresh = this.applicationStartup.start("spring.context.refresh");
          // 1. 刷新前准备：①启动时间②获取环境信息③ApplicationListener监听器
          this.prepareRefresh();
          // 2. ①获取一个Bean的容器:DefaultListableBeanFactory②加载配置文件中属性值到当前工程:BeanDefinition
          ConfigurableListableBeanFactory beanFactory = this.obtainFreshBeanFactory();
          // 3. 准备BeanFactory: 给工厂设置各种属性值
          this.prepareBeanFactory(beanFactory);
          try {
            // 4. 空方法:留给扩展实现
            this.postProcessBeanFactory(beanFactory);
            // 5. 实例化并注册BeanFactoryPostProcessor
            StartupStep beanPostProcess = this.applicationStartup.start("spring.context.beans.post-process");
            // 6. 实例化之前的准备工作:①
            this.invokeBeanFactoryPostProcessors(beanFactory);
            this.registerBeanPostProcessors(beanFactory);
            beanPostProcess.end();
            this.initMessageSource();
            this.initApplicationEventMulticaster();
            this.onRefresh();
            this.registerListeners();
            this.finishBeanFactoryInitialization(beanFactory);
            this.finishRefresh();
          } catch (BeansException var10) {
            if (this.logger.isWarnEnabled()) {
              this.logger.warn("Exception encountered during context initialization - cancelling refresh attempt: " + var10);
            }
            this.destroyBeans();
            this.cancelRefresh(var10);
            throw var10;
          } finally {
            this.resetCommonCaches();
            contextRefresh.end();
          }
        }
      }
    }
    ```

    