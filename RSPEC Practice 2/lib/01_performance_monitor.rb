
def measure(repeat_time=1 ,&block)
  pre_call = Time.now
  repeat_time.times {block.call}
  post_call = Time.now
  avg = (post_call - pre_call)/repeat_time
end
