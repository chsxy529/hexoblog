---
abbrlink: '0'
---
[redis]

# Redis介绍
***
## 什么是Redis？
***
- Redis 是用C语言开发的一个开源的高性能键值对（ key-value ）内存数据库，它是一种 NoSQL 数据库。 
- 它是【单进程单线程】的内存数据库，所以说不存在线程安全问题。 
- 它可以支持并发 10W QPS，所以说性能非常优秀。之所以单进程单线程性能还这么好，是因为底层采用了【IO 多路复用（NIO思想）】 
- 相比Memcache这种专业缓存技术，它有更优秀的读写性能，及丰富的数据类型。 
- 它提供了五种数据类型来存储【值】：字符串类型（string）、散列类型（hash）、列表类型（list）、集合 类型（set）、有序集合类型（sortedset、zset）

## Redis官网
***
官网地址：http://redis.io/ 
中文官网地址：http://www.redis.cn/ 
下载地址：http://download.redis.io/releases/

## 什么是NoSQL？
***
- NoSQL ，即 Not-Only SQL （不仅仅是 SQL ），泛指非关系型的数据库。

- 什么是关系型数据库？数据结构是一种有行有列的数据库

- NoSQL 数据库是为了解决高并发、高可用、高可扩展、大数据存储问题而产生的数据库解决方案。
- NoSQL 可以作为关系型数据库的良好补充，但是不能替代关系型数据库。

  MySQL（关系型数据库） ---> NoSQL ---> NewSQL（TiDB）

## NoSQL数据库分类

***

- 键值(Key-Value)存储数据库

相关产品： Tokyo Cabinet/Tyrant 、 Redis 、 Voldemort 、 Berkeley DB
典型应用： 内容缓存，主要用于处理大量数据的高访问负载。
数据模型： 一系列键值对
优势： 快速查询
劣势： 存储的数据缺少结构化

- 列存储数据库
相关产品： Cassandra , HBase , Riak
典型应用：分布式的文件系统
数据模型：以列簇式存储，将同一列数据存在一起
优势：查找速度快，可扩展性强，更容易进行分布式扩展
劣势：功能相对局限
- 文档型数据库
相关产品： CouchDB 、 MongoDB
典型应用： Web 应用（与 Key-Value 类似， Value 是结构化的）
数据模型： 一系列键值对
优势：数据结构要求不严格
劣势：
- 图形( Graph )数据库
相关数据库： Neo4J 、 InfoGrid 、 Infinite Graph
典型应用：社交网络
数据模型：图结构
优势：利用图结构相关算法。
劣势：需要对整个图做计算才能得出结果，不容易做分布式的集群方案。

## Redis发展历史

***

2008年，意大利的一家创业公司 Merzia 推出了一款基于 MySQL 的网站实时统计系统 LLOOGG ，然而没过多久该公司 的创始人 Salvatore Sanfilippo 便 对 MySQL 的性能感到失望，于是他决定亲自为 LLOOGG 量身定做一个数据 库，并于2009年开发完成，这个数据库就是 Redis 。 不过 Salvatore Sanfilippo 并不满足只将 Redis 用于 LLOOGG 这一款产品，而是希望更多的人使用它，于是在同 一年 Salvatore Sanfilippo 将 Redis 开源发布，并开始和 Redis 的另一名主要的代码贡献者 Pieter Noordhuis 一起继续着 Redis 的开发，直到今天。 Salvatore Sanfilippo 自己也没有想到，短短的几年时间， Redis 就拥有了庞大的用户群体。 Hacker News 在 2012年发布了一份数据库的使用情况调查，结果显示有近12%的公司在使用Redis。国内如新浪微博、街旁网、知乎 网，国外如 GitHub 、 Stack Overflow 、 Flickr 等都是 Redis 的用户。 VMware 公司从2010年开始赞助 Redis 的开发， Salvatore Sanfilippo 和 Pieter Noordhuis 也分别在3月和5 月加入 VMware ，全职开发 Redis 。

## Redis应用场景

***



- 内存数据库（登录信息、购物车信息、用户浏览记录等）
- 缓存服务器（商品数据、广告数据等等）（最多使用）
- 解决分布式集群架构中的 session 分离问题（ session 共享）
- 任务队列（秒杀、抢购、12306等等）
- 分布式锁的实现
- 支持发布订阅的消息模式
- 应用排行榜(有序集合)
- 网站访问统计
- 数据过期处理（可以精确到毫秒）

# Redis单机版安装配置

***

## Redis下载

***

官网地址：http://redis.io/ 
中文官网地址：http://www.redis.cn/ 
下载地址：http://download.redis.io/releases/

## Redis安装环境

***

Redis 没有官方的 Windows 版本，所以建议在 Linux 系统上安装运行，这里使用 CentOS 7 （ Linux 操作系统的一个系列）作为安装环境。

## Redis安装

***

第一步：安装 C 语言需要的 GCC 环境

```shell
yum install -y gcc-c++ 
yum install -y wget
```

第二步：下载并解压缩 Redis 源码压缩包

```shell
wget http://download.redis.io/releases/redis-5.0.4.tar.gz 
tar -zxf redis-5.0.4.tar.gz
```

第三步：编译 Redis 源码，进入 redis-3.2.9 目录，执行编译命令

```shell
cd redis-5.0.4 
make
```

第四步：安装 Redis ，需要通过 PREFIX 指定安装路径

```shell
make install PREFIX=/root/server/redis
```

## Redis启动

***

- 启动命令： redis-server ，直接运行 bin/redis-server 将以前端模式启动

	```shell
	./redis-server
	```

	

- 关闭命令： ctrl+c

- 启动缺点：客户端窗口关闭则 redis-server 程序结束，不推荐使用此方法
- 启动图例
![redis.PNG](https://upload-images.jianshu.io/upload_images/21149538-faea6ebd5ef3dc4c.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


## 后端启动（守护进程启动）

***

- 第一步：拷贝 redis-5.0.4/redis.conf 配置文件到 Redis 安装目录的 bin 目录

	```shell
	cp /root/redis-5.0.4/redis.conf /root/server/redis/bin/
	```

- 第二步：修改 redis.conf

	

	```shell
	vim redis.conf
	```

	```
	# 将`daemonize`由`no`改为`yes` 
	daemonize yes 
	# 默认绑定的是回环地址，默认不能被其他机器访问 
	# bind 127.0.0.1 
	# 是否开启保护模式，由yes该为no protected-mode no
	```

- 第三步：启动服务

	```
	 ./redis-server redis.conf
	```

	

## 后端启动的关闭方式

***

```shell
./redis-cli shutdown
```

## 其他命令说明

***

- redis-server ：启动 redis 服务 redis-cli ：进入 redis 命令客户端 
- redis-benchmark ： 性能测试的工具 
- redis-check-aof ： aof 文件进行检查的工具 
- redis-check-dump ： rdb 文件进行检查的工具 
- redis-sentinel ： 启动哨兵监控服务

# Redis客户端

***

## Redis命令行客户端

***
![redis-cli.PNG](https://upload-images.jianshu.io/upload_images/21149538-0bd031398fa50244.PNG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


- 命令格式

	```shell
	./redis-cli -h 127.0.0.1 -p 6379
	```

- 参数说明
	```shell
	-h：redis服务器的ip地址
	-p：redis实例的端口号
	```
	
- 默认方式
	如果不指定主机和端口也可以 
	`默认主机地址是127.0.0.1` 
	`默认端口是6379`
	
	```shell
	./redis-cli -h 127.0.0.1 -p 6379
	```

## Java客户端Jedis
***

### Jedis介绍

Redis不仅使用命令来操作，而且可以使用程序客户端操作。现在基本上主流的语言都有客户端支持，比如java、 C、C#、C++、php、Node.js、Go等。

在官方网站里列一些Java的客户端，有Jedis、Redisson、Jredis、JDBC-Redis、等其中官方推荐使用Jedis和 Redisson。 在企业中用的最多的就是Jedis，下面我们就重点学习下Jedis。 Jedis同样也是托管在github上，地址：https://github.com/xetorthio/jedis

### 添加依赖

```xml
<dependencies> 
  <dependency> 
    <groupId>redis.clients</groupId>  
    <artifactId>jedis</artifactId>  
    <version>2.9.0</version> 
  </dependency>  
  <dependency> 
    <groupId>org.springframework</groupId>  
    <artifactId>spring-context</artifactId>  
    <version>5.0.7.RELEASE</version> 
  </dependency>  
  <dependency> 
    <groupId>org.springframework</groupId>  
    <artifactId>spring-test</artifactId>  
    <version>5.0.7.RELEASE</version> 
  </dependency>  
  <!-- 单元测试Junit -->  
  <dependency> 
    <groupId>junit</groupId>  
    <artifactId>junit</artifactId>  
    <version>4.12</version> 
  </dependency> 
</dependencies>
<build> 
  <plugins> 
    <!-- 配置Maven的JDK编译级别 -->  
    <plugin> 
      <groupId>org.apache.maven.plugins</groupId>  
      <artifactId>maven-compiler-plugin</artifactId>  
      <version>3.2</version>  
      <configuration> 
        <source>1.8</source>  
        <target>1.8</target>  
        <encoding>UTF-8</encoding> 
      </configuration> 
    </plugin> 
  </plugins> 
</build>

```

### 单实例连接

```java
@Test
public void testJedis() {
	// 创建一个Jedis的连接
	Jedis jedis = new Jedis("127.0.0.1", 6379);
	// 执行redis命令
	jedis.set("mytest", "hello world, this is jedis client!");
	// 从redis中取值
	String result = jedis.get("mytest");
	// 打印结果
	System.out.println(result);
	// 关闭连接
	jedis.close();
}
```
### 连接池连接

```java
@Test
public void testJedisPool() {
	// 创建一连接池对象
	JedisPool jedisPool = new JedisPool("127.0.0.1", 6379);
	// 从连接池中获得连接
	Jedis jedis = jedisPool.getResource();
	String result = jedis.get("mytest");
	System.out.println(result);
	// 关闭连接
	jedis.close();
	// 关闭连接池
	jedisPool.close();
}
```
### 连接redis集群

```java
@Test
public void testJedisCluster() throws Exception {
	// 创建一连接，JedisCluster对象,在系统中是单例存在
	Set<HostAndPort> nodes = new HashSet<>();
	nodes.add(new HostAndPort("192.168.242.129", 7001));
	nodes.add(new HostAndPort("192.168.242.129", 7002));
	nodes.add(new HostAndPort("192.168.242.129", 7003));
	nodes.add(new HostAndPort("192.168.242.129", 7004));
	nodes.add(new HostAndPort("192.168.242.129", 7005));
	nodes.add(new HostAndPort("192.168.242.129", 7006));
	JedisCluster cluster = new JedisCluster(nodes);
	// 执行JedisCluster对象中的方法，方法和redis一一对应。
	cluster.set("cluster-test", "my jedis cluster test");
	String result = cluster.get("cluster-test");
	System.out.println(result);
	// 程序结束时需要关闭JedisCluster对象
	cluster.close();
}
```
### Jedis整合spring

配置spring配置文件applicationContext.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans
http://www.springframework.org/schema/beans/spring-beans.xsd">
	<!-- 连接池配置 -->
	<bean id="jedisPoolConfig"
		class="redis.clients.jedis.JedisPoolConfig">
		<!-- 最大连接数 -->
		<property name="maxTotal" value="30" />
		<!-- 最大空闲连接数 -->
		<property name="maxIdle" value="10" />
		<!-- 每次释放连接的最大数目 -->
		<property name="numTestsPerEvictionRun" value="1024" />
		<!-- 释放连接的扫描间隔（毫秒） -->
		<property name="timeBetweenEvictionRunsMillis" value="30000" />
		<!-- 连接最小空闲时间 -->
		<property name="minEvictableIdleTimeMillis" value="1800000" />
		<!-- 连接空闲多久后释放, 当空闲时间>该值 且 空闲连接>最大空闲连接数 时直接释放 -->
		<property name="softMinEvictableIdleTimeMillis" value="10000" />
		<!-- 获取连接时的最大等待毫秒数,小于零:阻塞不确定的时间,默认-1 -->
		<property name="maxWaitMillis" value="1500" />
		<!-- 在获取连接的时候检查有效性, 默认false -->
		<property name="testOnBorrow" value="true" />
		<!-- 在空闲时检查有效性, 默认false -->
		<property name="testWhileIdle" value="true" />
		<!-- 连接耗尽时是否阻塞, false报异常,ture阻塞直到超时, 默认true -->
		<property name="blockWhenExhausted" value="false" />
	</bean>
	<!-- redis单机 通过连接池 -->
	<bean id="jedisPool" class="redis.clients.jedis.JedisPool"
		destroy-method="close">
		<constructor-arg name="poolConfig"
			ref="jedisPoolConfig" />
		<constructor-arg name="host" value="192.168.10.135" />
		<constructor-arg name="port" value="6379" />
	</bean>
	<!-- redis集群 -->
	<bean id="jedisCluster" class="redis.clients.jedis.JedisCluster">
		<constructor-arg index="0">
			<set>
				<bean class="redis.clients.jedis.HostAndPort">
					<constructor-arg index="0" value="192.168.10.135">
					</constructorarg>
						<constructor-arg index="1" value="7001"></constructor-arg>
				</bean>
				<bean class="redis.clients.jedis.HostAndPort">
					<constructor-arg index="0" value="192.168.10.135">
					</constructorarg>
						<constructor-arg index="1" value="7002"></constructor-arg>
				</bean>
				<bean class="redis.clients.jedis.HostAndPort">
					<constructor-arg index="0" value="192.168.10.135">
					</constructorarg>
						<constructor-arg index="1" value="7003"></constructor-arg>
				</bean>
				<bean class="redis.clients.jedis.HostAndPort">
					<constructor-arg index="0" value="192.168.10.135">
					</constructorarg>
						<constructor-arg index="1" value="7004"></constructor-arg>
				</bean>
				<bean class="redis.clients.jedis.HostAndPort">
					<constructor-arg index="0" value="192.168.10.135">
					</constructorarg>
						<constructor-arg index="1" value="7005"></constructor-arg>
				</bean>
				<bean class="redis.clients.jedis.HostAndPort">
					<constructor-arg index="0" value="192.168.10.135">
					</constructorarg>
						<constructor-arg index="1" value="7006"></constructor-arg>
				</bean>
			</set>
		</constructor-arg>
		<constructor-arg index="1" ref="jedisPoolConfig"></constructor-arg>
	</bean>
</beans>
```

测试代码
```java
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:application.xml")
public class TestJedis2 {
	@Autowired
	private JedisPool jedisPool;
	@Resource
	private JedisCluster cluster;

	@Test
	public void testJedisPool() {
// 从连接池中获得连接
		Jedis jedis = jedisPool.getResource();
		String result = jedis.get("mytest");
		System.out.println(result);
// 关闭连接
		jedis.close();
	}

	@Test
	public void testJedisCluster() throws Exception {
// 执行JedisCluster对象中的方法，方法和redis一一对应。
		cluster.set("cluster-test", "my jedis cluster test");
		String result = cluster.get("cluster-test");
		System.out.println(result);
	}
}
```

# Redis数据类型

***


官方命令大全网址：http://www.redis.cn/commands.html 

Redis 中存储数据是通过 key-value 格式存储数据的，其中 value 可以定义五种数据类型：

- String（字符类型） 
- Hash（散列类型
- List（列表类型）
- Set（集合类型） 
- SortedSet（有序集合类型，简称zset）

注意：在 redis 中的命令语句中，命令是忽略大小写的，而 key 是不忽略大小写的。

## string类型

### 赋值
- 语法：

	```
	SET key value
	```

- 示例
	```
	127.0.0.1:6379> set test 123
	OK
	```

### 取值
- 语法：

	```
	GET key value
	```

- 示例
	```
	127.0.0.1:6379> get test
	"123"
	```

### 取值并赋值
- 语法：

	```
	GETSET key value
	```

- 示例
	```
	127.0.0.1:6379> getset s2 222
	"111"
	127.0.0.1:6379> get s2
	"222"
	```

### 数值增减

**注意事项**

1. 当value为整数数据时，才能使用以下命令操作数值的增减。 
2. 数值递增都是【原子】操作。
3. redis中的每一个单独的命令都是原子性操作。当多个命令一起执行的时候，就不能保证原子性，不过我们可以使 用事务和lua脚本来保证这一点。

**非原子性操作示例**：

```java
int i = 1; 
i++; 
System.out.println(i)
```

### 递增数字
- 语法（increment）：

	```
	INCR key
	```

- 示例
	```
	127.0.0.1:6379> incr num
	(integer) 1
	127.0.0.1:6379> incr num
	(integer) 2
	127.0.0.1:6379> incr num
	(integer) 3
	```

### 增加指定的整数
- 语法：

	```
	INCRBY key increment
	```

- 示例
	```
	127.0.0.1:6379> incrby num 2
	(integer) 5
	127.0.0.1:6379> incrby num 2
	(integer) 7
	127.0.0.1:6379> incrby num 2
	(integer) 9
	```

### 递减数值

- 语法：

	```
	DECR key
	```

- 示例
	```
	127.0.0.1:6379> decr num
	(integer) 3
	127.0.0.1:6379> decr num
	(integer) 2
	127.0.0.1:6379> decr num
	(integer) 1
	```

### 减少指定的整数
- 语法：

	```
	DECRBY key decrement
	```

- 示例
	```
	127.0.0.1:6379> decr num
	(integer) 6
	127.0.0.1:6379> decr num
	(integer) 5
	127.0.0.1:6379> decrby num 3
	(integer) 2
	127.0.0.1:6379> decrby num 3
	(integer) -1
	```

### 仅当不存在时赋值

`使用该命令可以实现【分布式锁】的功能`
- 语法：

	```
	setnx key value
	```

- 示例
	```
	redis> EXISTS job # job 不存在
	(integer) 0
	redis> SETNX job "programmer" # job 设置成功
	(integer) 1
	redis> SETNX job "code-farmer" # 尝试覆盖 job ，失败
	(integer) 0
	redis> GET job # 没有被覆盖
	"programmer"

	```

### 其它命令

#### 向尾部追加值APPEND 

APPEND 命令，向键值的末尾追加 value 。 如果键不存在则将该键的值设置为 value ，即相当于 SET key value 。返回值是追加后字符串的总长度。
- 语法：

	```
	APPEND key value
	```

- 示例
	```
	127.0.0.1:6379> set str hello
	OK
	127.0.0.1:6379> append str " world!"
	(integer) 12
	127.0.0.1:6379> get str
	"hello world!"
	```

#### 获取字符串长度

STRLEN 命令，返回键值的长度，如果键不存在则返回0。
- 语法：

	```
	STRLEN key
	```

- 示例
	```
	127.0.0.1:6379> strlen str
	(integer) 0
	127.0.0.1:6379> set str hello
	OK
	127.0.0.1:6379> strlen str
	(integer) 5
	```

#### 同时设置/获取多个键值

- 语法：

	```
	MSET key value [key value …]
	MGET key [key …]

	```

- 示例
	```
	127.0.0.1:6379> mset k1 v1 k2 v2 k3 v3
	OK
	127.0.0.1:6379> get k1
	"v1"
	127.0.0.1:6379> mget k1 k3
	1) "v1"
	2) "v3"
	```

### 应用场景之自增主键

- 需求：商品编号、订单号采用 INCR 命令生成。

- 设计： key 命名要有一定的设计 

- 实现：定义商品编号 key ： items:id
```
192.168.101.3:7003> INCR items:id
(integer) 2
192.168.101.3:7003> INCR items:id
(integer) 3
```



## Hash

***

hash类型介绍

hash类型介绍 hash 类型也叫散列类型，它提供了字段和字段值的映射。字段值只能是字符串类型，不支持散列类型、集合类型等 其它类型。

### 赋值

***

设置一个字段值
- 语法

	```
	HSET key field value
	```

- 示例
	```
	1127.0.0.1:6379> hset user username zhangsan
	(integer) 1
	```

	

设置多个字段值	
- 语法

	```
	HMSET key field value [field value ...]
	```

- 示例
	```
	127.0.0.1:6379> hmset user age 20 username lisi
	OK
	```

当字段不存在时赋值

类似 HSET ，区别在于如果字段存在，该命令不执行任何操作

- 语法

	```
	HSETNX key field value
	```

- 示例
	```
	127.0.0.1:6379> hsetnx user age 30 # 如果user中没有age字段则设置age值为		30，否则不做任何操作
	(integer) 0
	```

### 取值

***

获取一个字段值
- 语法

	```
	HGET key field
	```

- 示例
	```
	127.0.0.1:6379> hget user username
	"zhangsan“
	```
获取多个字段值
	
- 语法

	```
	HMGET key field [field ...]
	```

- 示例
	```
	127.0.0.1:6379> hmget user age username
	1) "20"
	2) "lisi"
	```
获取所有字段值
	
- 语法

	```
	HGETALL key
	```

- 示例
	```
	127.0.0.1:6379> hgetall user
	1) "age"
	2) "20"
	3) "username"
	4) "lisi"
	```

	
	
	
	
	
### 删除字段

可以删除一个或多个字段，返回值是被删除的字段个数

- 语法

	```
	HGETALL key
	```

- 示例
	```
	127.0.0.1:6379> hgetall user
	1) "age"
	2) "20"
	3) "username"
	4) "lisi"
	```



### 增加数字
- 语法

	```
	HINCRBY key field increment
	```

- 示例
	```
	127.0.0.1:6379> hincrby user age 2 # 将用户的年龄加2
	(integer) 22
	127.0.0.1:6379> hget user age # 获取用户的年龄
	"22“
	```
### 其他命令
判断字段是否存在
- 语法
	```
	HEXISTS key field
	```
- 示例
	```
	127.0.0.1:6379> hexists user age 查看user中是否有age字段
	(integer) 1
	127.0.0.1:6379> hexists user name 查看user中是否有name字段
	(integer) 0
	```
只获取字段名或字段值
- 语法
	```
	HKEYS key
	HVALS key
	```
- 示例
	```
	127.0.0.1:6379> hmset user age 20 name lisi
	OK
	127.0.0.1:6379> hkeys user
	1) "age"
	2) "name"
	127.0.0.1:6379> hvals user
	1) "20"
	2) "lisi"
	```
获取字段数量
- 语法
	```
	HLEN key
	```
- 示例
	```
	127.0.0.1:6379> hlen user
	(integer) 2
	```
获取所有字段
- 语法
	```
	hgetall key
	```

### string类型和hash类型的区别

hash类型适合存储那些对象数据，特别是对象属性经常发生【增删改】操作的数据。 string类型也可以存储对象数 据，将java对象转成json字符串进行存储，这种存储适合【查询】操作。

**应用之存储商品信息**

- 商品信息字段

	```
	【商品id、商品名称、商品描述、商品库存、商品好评】
	```

- 定义商品信息的key

	```
	- 商品ID为1001的信息在 Redis中的key为：[items:1001]
	```

- 存储商品信息

	```
	192.168.101.3:7003> HMSET items:1001 id 3 name apple price 999.9 
	OK
	```

- 获取商品信息
	```
	192.168.101.3:7003> HGET items:1001 id
	"3"
	192.168.101.3:7003> HGETALL items:1001
	1) "id"
	2) "3"
	3) "name"
	4) "apple"
	5) "price"
	6) "999.9"
	```
	

## list类型

***

### ArrayList与LinkedList的区别

ArrayList 使用数组方式存储数据，所以根据索引查询数据速度快，而新增或者删除元素时需要设计到位移操作， 所以比较慢。

 LinkedList 使用双向链表方式存储数据，每个元素都记录前后元素的指针，所以插入、删除数据时只是更改前后元 素的指针指向即可，速度非常快。然后通过下标查询元素时需要从头开始索引，所以比较慢，但是如果查询前几个元 素或后几个元素速度比较快。

### list类型介绍

Redis 的列表类型（ list 类型）可以 存储一个有序的字符串列表 ，常用的操作是向列表两端添加元素，或者获得列表 的某一个片段。 

列表类型内部是使用双向链表（ double linked list ）实现的，所以向列表两端添加元素的时间复杂度为 0(1) ，获取越接近两端的元素速度就越快。这意味着即使是一个有几千万个元素的列表，获取头部或尾部的10条记 录也是极快的。

### LPUSH/RPUSH
- 语法
	```
	LPUSH key value [value ...]
	RPUSH key value [value ...]
	```
- 示例
	```
	127.0.0.1:6379> lpush list:1 1 2 3
	(integer) 3
	127.0.0.1:6379> rpush list:1 4 5 6
	(integer) 3
	```
### LRANGE

获取列表中的某一片段。将返回`start`、`stop`之间的所有元素（包含两端的元素），索引从`0`开始。索引可以 是负数，如：“`-1`”代表最后边的一个元素。

- 语法
	```
	LRANGE key start stop
	```
- 示例
	```
	127.0.0.1:6379> lrange list:1 0 2
	1) "2"
	2) "1"
	3) "4"
	```
### LPOP/RPOP
从列表两端弹出元素
从列表左边弹出一个元素，会分两步完成：
1. 第一步是将列表左边的元素从列表中移除
2. 第二步是返回被移除的元素值。

- 语法
	```
	LPOP key
	RPOP key
	```
- 示例
	```
	127.0.0.1:6379>lpop list:1
	"3“
	127.0.0.1:6379>rpop list:1
	"6“
	```
### LLEN
获取列表中元素的个数

- 语法
	```
	llen key
	```
- 示例
	```
	127.0.0.1:6379> llen list:1
	(integer) 2
	```
### LREM
删除列表中指定个数的值
LREM 命令会删除列表中前 count 个值为 value 的元素，返回实际删除的元素个数。根据 count 值的不同，该命令的
执行方式会有所不同：
- 当count>0时， LREM会从列表左边开始删除。
- 当count<0时， LREM会从列表后边开始删除。
- 当count=0时， LREM删除所有值为value的元素。

- 语法
	```
	LREM key count value
	```

### LINDEX
获得指定索引的元素值

- 语法
	```
	LINDEX key index
	```
- 示例
	```
	127.0.0.1:6379>lindex l:list 2
	"1"
	```
### LINDEX
获得指定索引的元素值

- 语法
	```
	LINDEX key index
	```
- 示例
	```
	127.0.0.1:6379>lindex l:list 2
	"1"
	```


### 设置指定索引的元素值
- 语法
	```
	LSET key index value
	```
- 示例
	
	```
	127.0.0.1:6379> lset l:list 2 2 
	OK 
	127.0.0.1:6379> lrange l:list 0 -1 
	1) "6" 
	2) "5" 
	3) "2" 
	4)"2"
	```
### LTRIM只保留列表指定片段,指定范围和LRANGE一致
- 语法
	```
	LTRIM key start stop
	```
- 示例
	
	```
	127.0.0.1:6379> lrange l:list 0 -1
	1) "6"
	2) "5"
	3) "0"
	4) "2"
	127.0.0.1:6379> ltrim l:list 0 2
	OK
	127.0.0.1:6379> lrange l:list 0 -1
	1) "6"
	2) "5"
	3) "0"
	```
### LINSERT
向列表中插入元素。
该命令首先会在列表中从左到右查找值为pivot的元素，然后根据第二个参数是BEFORE还是AFTER来决定将value插
入到该元素的前面还是后面。

- 语法
	```
	LINSERT key BEFORE|AFTER pivot value
	```
- 示例
	
	```
	127.0.0.1:6379> lrange list 0 -1
	1) "3"
	2) "2"
	3) "1"
	127.0.0.1:6379> linsert list after 3 4
	(integer) 4
	127.0.0.1:6379> lrange list 0 -1
	1) "3"
	2) "4"
	3) "2"
	4) "1"
	```
### RPOPLPUSH
将元素从一个列表转移到另一个列表中

- 语法
	```
	RPOPLPUSH source destination
	```
- 示例
	
	```
	127.0.0.1:6379> rpoplpush list newlist
	"1"
	127.0.0.1:6379> lrange newlist 0 -1
	1) "1"
	127.0.0.1:6379> lrange list 0 -1
	1) "3"
	2) "4"
	3) "2"
	```

### 应用之商品评论列表

- 需求：

	用户针对某一商品发布评论，一个商品会被不同的用户进行评论，存储商品评论时，要按时间顺序排序。 用户在前端页面查询该商品的评论，需要按照时间顺序降序排序。

- 分析：

	​	使用list存储商品评论信息，KEY是该商品的ID，VALUE是商品评论信息列表

- 实现：

	商品编号为 1001 的商品评论 key 【 items: comment:1001 】

	```
	192.168.101.3:7001> LPUSH items:comment:1001 '{"id":1,"name":"商品不错，很 好！！","date":1430295077289}'
	```

	

## set类型

***

### set类型介绍

set 类型即集合类型，其中的数据是不重复且没有顺序。

集合类型和列表类型的对比：

|          | 集合类型                     | 列表类型                     |
| -------- | ---------------------------- | ---------------------------- |
| 存储内容 | 至多2<sup>32</sup>-1个字符串 | 至多2<sup>32</sup>-1个字符串 |
| 有序性   | 否                           | 是                           |
| 唯一性   | 是                           | 否                           |

集合类型的常用操作是向集合中加入或删除元素、判断某个元素是否存在等，由于集合类型的 Redis 内部是使用值 为空的散列表实现，所有这些操作的时间复杂度都为 0(1) 。

 Redis 还提供了多个集合之间的交集、并集、差集的运算。

### SADD/SREM
添加元素/删除元素

- 语法
	```
	SADD key member [member ...]
	SREM key member [member ...]
	```
- 示例
	
	```
	127.0.0.1:6379> sadd set a b c
    (integer) 3
    127.0.0.1:6379> sadd set a
    (integer) 0
    127.0.0.1:6379> srem set c d
    (integer) 1

	```
### SMEMBERS
获得集合中的所有元素
- 语法
	```
	SMEMBERS key
	```
- 示例
	
	```
	127.0.0.1:6379> smembers set
	1) "b"
	2) "a”
	```
### SISMEMBER
判断元素是否在集合中
- 语法
	```
	SISMEMBER key member
	```
- 示例
	
	```
	127.0.0.1:6379>sismember set a
	(integer) 1
	127.0.0.1:6379>sismember set h
	(integer) 0
	```
### SDIFF
集合的差集运算 A-B：属于A并且不属于B的元素构成的集合
- 语法
	```
	SDIFF key [key ...]
	```
- 示例
	
	```
	127.0.0.1:6379> sadd setA 1 2 3
	(integer) 3
	127.0.0.1:6379> sadd setB 2 3 4
	(integer) 3
	127.0.0.1:6379> sdiff setA setB
	1) "1"
	127.0.0.1:6379> sdiff setB setA
	1) "4"
	```
### SINTER
集合的交集运算 A ∩ B：属于A且属于B的元素构成的集合。
- 语法
	```
	SINTER key [key ...]
	```
- 示例
	
	```
	127.0.0.1:6379> sinter setA setB
	1) "2"
	2) "3"
	```
### SUNION
集合的并集运算 A ∪ B：属于A或者属于B的元素构成的集合
- 语法
	```
	SUNION key [key ...]
	```
- 示例
	
	```
	127.0.0.1:6379> sunion setA setB
	1) "1"
	2) "2"
	3) "3"
	4) "4"
	```
### SCARD
获得集合中元素的个数
- 语法
	```
	SCARD key
	```
- 示例
	
	```
	127.0.0.1:6379> smembers setA
	1) "1"
	2) "2"
	3) "3"
	127.0.0.1:6379> scard setA
	(integer) 3
	```
### SPOP
从集合中弹出一个元素。
注意：由于集合是无序的，所有SPOP命令会从集合中随机选择一个元素弹出

- 语法
	```
	SPOP key

	```
- 示例
	
	```
	127.0.0.1:6379> spop setA
	"1“
	```

## zset类型 （sortedset）

***

### zset介绍

在 set 集合类型的基础上，有序集合类型为集合中的每个元素都 关联一个分数 ，这使得我们不仅可以完成插入、删除 和判断元素是否存在在集合中，还能够获得分数最高或最低的前N个元素、获取指定分数范围内的元素等与分数有关 的操作。

在某些方面有序集合和列表类型有些相似：

1. 二者都是有序的。 
2. 二者都可以获得某一范围的元素。

但是，二者有着很大区别：

1. 列表类型是通过链表实现的，获取靠近两端的数据速度极快，而当元素增多后，访问中间数据的速度会变慢。
2. 有序集合类型使用散列表实现，所有即使读取位于中间部分的数据也很快。
3. 列表中不能简单的调整某个元素的位置，但是有序集合可以（通过更改分数实现）
4. 有序集合要比列表类型更耗内存。

### ZADD
增加元素。
向有序集合中加入一个元素和该元素的分数，如果该元素已经存在则会用新的分数替换原有的分数。返回值是新加入到
集合中的元素个数，不包含之前已经存在的元素
- 语法
	```
	ZADD key score member [score member ...]
	```
- 示例
	
	```
	127.0.0.1:6379> zadd scoreboard 80 zhangsan 89 lisi 94 wangwu
	(integer) 3
	127.0.0.1:6379> zadd scoreboard 97 lisi
	(integer) 0
	```
### ZRANGE/ZREVRANGE
增加元素。
获得排名在某个范围的元素列表。
- ZRANGE：按照元素分数从小到大的顺序返回索引从start到stop之间的所有元素（包含两端的元素）
- ZREVRANGE：按照元素分数从大到小的顺序返回索引从start到stop之间的所有元素（包含两端的元素）
- 语法
	```
	ZRANGE key start stop [WITHSCORES]
	ZREVRANGE key start stop [WITHSCORES]
	```
- 示例
	
	```
	127.0.0.1:6379> zrange scoreboard 0 2
	1) "zhangsan"
	2) "wangwu"
	3) "lisi“
	127.0.0.1:6379> zrevrange scoreboard 0 2
	1) " lisi "
	2) "wangwu"
	3) " zhangsan “
	```
	- 如果需要获得元素的分数的可以在命令尾部加上 WITHSCORES 参数
	```
	127.0.0.1:6379> zrange scoreboard 0 1 WITHSCORES
	1) "zhangsan"
	2) "80"
	3) "wangwu"
	4) "94"
	```
### ZSCORE
获取元素的分数
- 语法
	```
	ZSCORE key member
	```
- 示例
	
	```
	127.0.0.1:6379> zscore scoreboard lisi
	"97"
	```
### ZREM
删除元素。
移除有序集合key中的一个或多个成员，不存在的成员将被忽略。
当key存在但不是有序集类型时，返回一个错误。

- 语法
	```
	ZREM key member [member ...]
	```
- 示例
	
	```
	127.0.0.1:6379> zrem scoreboard lisi
	(integer) 1
	```
### ZRANGEBYSCORE
获得指定分数范围的元素。

- 语法
	```
	ZRANGEBYSCORE key min max [WITHSCORES]
	```
- 示例
	
	```
	127.0.0.1:6379> ZRANGEBYSCORE scoreboard 90 97 WITHSCORES
	1) "wangwu"
	2) "94"
	3) "lisi"
	4) "97"
	127.0.0.1:6379> ZRANGEBYSCORE scoreboard 70 100 limit 1 2
	1) "wangwu"
	2) "lisi"
	```
### ZINCRBY
增加某个元素的分数。
返回值是更改后的分数。

- 语法
	```
	ZINCRBY key increment member
	```
- 示例
	
	```
	127.0.0.1:6379> ZINCRBY scoreboard 4 lisi
	"101“
	```
### ZCARD
获得集合中元素的数量。
- 语法
	```
	ZCARD key
	```
- 示例
	
	```
	127.0.0.1:6379> ZCARD scoreboard
	(integer) 3
	```
### ZCOUNT
获得指定分数范围内的元素个数。
- 语法
	```
	ZCOUNT key min max
	```
- 示例
	
	```
	127.0.0.1:6379> ZCOUNT scoreboard 80 90
	(integer) 1

	```
### ZREMRANGEBYRANK
按照排名范围删除元素。
- 语法
	```
	ZREMRANGEBYRANK key start stop
	```
- 示例
	
	```
	127.0.0.1:6379> ZREMRANGEBYRANK scoreboard 0 1
	(integer) 2
	127.0.0.1:6379> ZRANGE scoreboard 0 -1
	1) "lisi"
	```
### ZREMRANGEBYSCORE
按照分数范围删除元素。
- 语法
	```
	ZREMRANGEBYSCORE key min max
	```
- 示例
	
	```
	127.0.0.1:6379> zadd scoreboard 84 zhangsan
	(integer) 1
	127.0.0.1:6379> ZREMRANGEBYSCORE scoreboard 80 100
	(integer) 1
	```
### ZRANK/ZREVRANK
获取元素的排名。
- ZRANK：从小到大
- ZREVRANK：从大到小。
- 语法
	```
	ZRANK key member
	ZREVRANK key member
	```
- 示例
	
	```
	127.0.0.1:6379> ZRANK scoreboard lisi
	(integer) 0
	127.0.0.1:6379> ZREVRANK scoreboard zhangsan
	(integer) 1
	```

### 应用之商品销售排行榜

- 需求：

	```
	根据商品销售量对商品进行排行显示
	```

- 设计：

	```
	 定义商品销售排行榜（sorted set集合），Key为items:sellsort，分数为商品销售量。
	```

- 写入商品销售量：

	商品编号 1001 的销量是 9 ，商品编号 1002 的销量是 10
	
	```
	192.168.101.3:7007> ZADD items:sellsort 9 1001 10 1002
	```
	
	商品编号 1001 的销量加 1
	
	```
	192.168.101.3:7001> ZINCRBY items:sellsort 1 1001
	```
	
	商品销量前 10 名：
	
	```
	192.168.101.3:7001> ZREVRANGE items:sellsort 0 9 withscores
	```



## 通用命令
### keys
返回满足给定pattern 的所有key

- 语法
	```
	keys pattern
	```
- 示例
	
	```
	redis 127.0.0.1:6379> keys mylist*
	1) "mylist"
	2) "mylist5"
	3) "mylist6"
	4) "mylist7"
	5) "mylist8"
	```
### keys
返回满足给定pattern 的所有key

- 语法
	```
	keys pattern
	```
- 示例
	
	```
	redis 127.0.0.1:6379> keys mylist*
	1) "mylist"
	2) "mylist5"
	3) "mylist6"
	4) "mylist7"
	5) "mylist8"
	```
### del
- 语法
	```
	DEL key
	```
- 示例
	
	```
	127.0.0.1:6379> del test
	(integer) 1
	```
### del
- 语法
	```
	DEL key
	```
- 示例
	
	```
	127.0.0.1:6379> del test
	(integer) 1
	```
### exists
确认一个key 是否存在
- 语法
	```
	exists key
	```
- 示例 ：从结果来看，数据库中不存在 HongWan 这个 key ，但是 age 这个 key 是存在的
	
	```
	redis 127.0.0.1:6379> exists HongWan
	(integer) 0
	redis 127.0.0.1:6379> exists age
	(integer) 1
	redis 127.0.0.1:6379>
	```
### expire
Redis在实际使用过程中更多的用作缓存，然而缓存的数据一般都是需要设置生存时间的，即：到期后数据销毁。
- 语法
	```
	EXPIRE key seconds 设置key的生存时间（单位：秒）key在多少秒后会自动删除
	TTL key 查看key生于的生存时间
	PERSIST key 清除生存时间
	PEXPIRE key milliseconds 生存时间设置单位为：毫秒
	```
- 示例 
	
	```
	192.168.101.3:7002> set test 1 设置test的值为1
	OK
	192.168.101.3:7002> get test 获取test的值
	"1"
	192.168.101.3:7002> EXPIRE test 5 设置test的生存时间为5秒
	(integer) 1
	192.168.101.3:7002> TTL test 查看test的生于生成时间还有1秒删除
	(integer) 1
	192.168.101.3:7002> TTL test
	(integer) -2
	192.168.101.3:7002> get test 获取test的值，已经删除
	(nil)
	```
### rename
重命名key
- 语法
	```
	rename oldkey newkey
	```
- 示例 ： age 成功的被我们改名为 age_new 了
	
	```
	redis 127.0.0.1:6379[1]> keys *
	1) "age"
	redis 127.0.0.1:6379[1]> rename age age_new
	OK
	redis 127.0.0.1:6379[1]> keys *
	1) "age_new"
	redis 127.0.0.1:6379[1]>
	```
### type
显示指定key的数据类型
- 语法
	```
	type key
	```
- 示例：这个方法可以非常简单的判断出值的类型
	
	```
	redis 127.0.0.1:6379> type addr
	string
	redis 127.0.0.1:6379> type myzset2
	zset
	redis 127.0.0.1:6379> type mylist
	list
	redis 127.0.0.1:6379>
	```

# Redis消息模式

## 队列模式

使用list类型的lpush和rpop实现消息队列

注意事项： 

- 消息接收方如果不知道队列中是否有消息，会一直发送rpop命令，如果这样的话，会每一次都建立一次连接， 这样显然不好。 
- 可以使用brpop命令，它如果从队列中取不出来数据，会一直阻塞，在一定范围内没有取出则返回null、

## 发布订阅模式

- 订阅消息（subscribe）

	示例：

	```
	subscribe channel
	```

- 发布消息（publish）

	```
	publish channel “test”
	```

- Redis发布订阅命令

	```
	#将信息发送到指定的频道
	publish channel message
	#订阅给定的一个或多个频道信息
	subscribe channel [channel...]
	#指推定給定的频道
	unsubscribe channel [channel...]
	```
# Redis事务

***

## Redis事务介绍

- Redis 的事务是通过 MULTI 、 EXEC 、 DISCARD 和 WATCH 、UNWATCH这五个命令来完成的。 
- Redis 的单个命令都是原子性的，所以这里需要确保事务性的对象是命令集合。 
- Redis 将命令集合序列化并确保处于同一事务的命令集合连续且不被打断的执行 
- Redis 不支持回滚操作。

## 事务命令

### MULTI

用于标记事务块的开始。 Redis会将后续的命令逐个放入队列中，然后使用EXEC命令原子化地执行这个命令序列。

### EXEC

在一个事务中执行所有先前放入队列的命令，然后恢复正常的连接状态

### DISCARD

当某个[事务需要按条件执行]时，就要使用这个命令将给定的[键设置为受监控]的状态。

`注意事项：使用该命令可以实现 Redis 的乐观锁。`

### UNWATCH

清除所有先前为一个事务监控的键。

### 事务演示
	127.0.0.1:6379> multi
	OK
	127.0.0.1:6379> set s1 111
	QUEUED
	127.0.0.1:6379> hset set1 name zhangsan
	QUEUED
	127.0.0.1:6379> exec
	1) OK
	2) (integer) 1
	127.0.0.1:6379> multi
	OK
	127.0.0.1:6379> set s2 222
	QUEUED
	127.0.0.1:6379> hset set2 age 20
	QUEUED
	127.0.0.1:6379> discard
	OK
	127.0.0.1:6379> exec
	(error) ERR EXEC without MULTI
	127.0.0.1:6379> watch s1
	OK
	127.0.0.1:6379> multi
	OK
	127.0.0.1:6379> set s1 555
	QUEUED
	127.0.0.1:6379> exec # 此时在没有exec之前，通过另一个命令窗口对监控的s1字段进行修改
	(nil)
	127.0.0.1:6379> get s1
	111

### 事务失败处理

Redis 不支持事务回滚 

1. 大多数事务失败是因为语法错误或者类型错误，这两种错误，在开发阶段都是可以预见的 
2. Redis 为了性能方面就忽略了事务回滚。