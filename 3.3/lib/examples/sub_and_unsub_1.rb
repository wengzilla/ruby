require 'pubnub'

# I should get a message on channel a once a second, but it doesnt appear so... why not?
# x.channel is always nil - please fix

p = Pubnub.new(:subscribe_key => "demo", :publish_key => "demo")

cb1 = lambda { |x| puts("cb1 #{x.channel}: msg: #{x.message} response: #{x.response}") }
cb2 = lambda { |x| puts("cb2 #{x.channel}: msg: #{x.message} response: #{x.response}") }
cb3 = lambda { |x| puts("cb3 #{x.channel}: msg: #{x.message} response: #{x.response}") }

puts("Subscribing on ch a!")
#p.subscribe(:channel => "a", :callback => cb1, :http_sync => false)
puts("Sleeping...")
sleep(3)
puts("Awoke!")
puts("Subscribing on ch ping_3!")
p.subscribe(:channel => "ping_3,a", :callback => cb2, :http_sync => false)


# Provide example of pubnub subcribe with block here
p.subscribe(:channel => "ping_3", :http_sync => false){ |envelope| puts envelope.message }
p.subscribe(:channel => "a", :http_sync => false){ |envelope| puts envelope.message }

x = 1000000

while (x > 0) do

  puts("sleeping...")
  sleep 1
  x=x-1

end

puts("**** Unsubscribing from A Start")
p.unsubscribe(:channel => "a", :callback => cb3)
puts("**** Unsubscribing from A Complete (no more CB3)")

# even after i unsub, im still getting messages (via cb1), why?

x = 3

while (x > 0) do

  puts("sleeping...")
  sleep 1
  x=x-1

end


x = 3
while (x > 0) do

  x=x-1
  puts("Looping quietly while the world goes on...")
  sleep 3

  p.publish(:publish_key => 'demo', :channel => 'hello_world', :message => 'whatever'){|e| puts e.inspect}

end