# defmodule GenericServerProcess do
#   def start(callback_module) do
#     spawn(fn ->
#       initial_state = callback_module.init()
#       loop(callback_module, initial_state)
#     end)
#   end

#   def loop(callback_module, current_state) do
#     receive do
#       {:call, request, caller} ->
#         {response, new_state} = callback_module.handle_call(request, current_state)
#         send(caller, {:response, response})

#         loop(callback_module, new_state)

#       {:cast, request} ->
#         new_state =
#           callback_module.handle_cast(
#             request,
#             current_state
#           )

#         loop(callback_module, new_state)
#     end
#   end

#   def call(pid, request) do
#     send(pid, {:call, request, self})

#     receive do
#       {:response, response} -> response
#     end
#   end

#   def cast(pid, request) do
#     send(pid, {:cast, request})
#   end
# end

defmodule KeyValueStore do
  use GenServer

  def start do
    GenServer.start(KeyValueStore, nil)
  end

  def put(pid, key, value) do
    GenServer.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  def init do
    Map.new()
  end

  def handle_call({:put, key, value}, state) do
    {:ok, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, state) do
    {Map.get(state, key), state}
  end

  def handle_cast({:put, key, value}, state) do
    Map.put(state, key, value)
  end
end
