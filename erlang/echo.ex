defmodule Echo do

  def start do
    spawn(__MODULE__, :loop, [])
  end

  def send_message(to_pid, from_pid, msg) do
    send(to_pid, {from_pid, msg})
  end

  def loop do
    receive do
      {sender_pid, msg} ->
        IO.puts "#{inspect sender_pid} said: #{msg}"
        send(sender_pid, {self, msg})
    end
    loop
  end

end