---
layout: default
title: One way to create singleton learned from Rails
---
# One way to create singleton learned from Rails
## The code

{% highlight ruby %}
   class Singleton
     class << self
       def instance
         @instance  ||= new
       end

       def respond_to_missing?(*args)
         instance.respond_to?(*args)
       end
       protected
         def method_missing(name, *args, &block)
           if instance.respond_to?(name)
             instance.public_send(name, *args, &block)
           end
         end
     end

     def instance_method_1
     end

     def instance_method_2
     end
   end
{% endhighlight %}
### Explanation

When we call Singleton.instance\_method\_1, the receiver is Singleton, which is a object of Class. Since the object Singleton does not has a method with name *instance\_method\_1*, the method respond\_to\_missing? will be invoked. Then the instance method is called to get or create a instance of Singleton, then the instance method instance_method\_1 is called.
