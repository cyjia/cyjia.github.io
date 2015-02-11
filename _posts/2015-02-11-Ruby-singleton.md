# One way to create singleton learned from Rails
## The code

   class Singleton
     class << self
       def instance
         @instance  ||= new
       end

       def respond_to_missing?(*args)
         instance.respond_to?(*args)
       end
     end
   end

### Explanation
