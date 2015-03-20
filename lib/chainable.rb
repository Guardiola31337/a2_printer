module Chainable

  def next_in_chain(link)
    @next = link
  end

  def method_missing(method, *args, &block)
    if @next == nil
      puts "This request cannot be handled!"
      return
    end
    @next.__send__(method, *args, &block)
  end
end
