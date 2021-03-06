defmodule Xcribe.Recorder do
  @moduledoc false

  use GenServer

  alias Xcribe.{Request, Request.Error}

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def save(%Request{} = request) do
    GenServer.cast(__MODULE__, {:save, request})
  end

  def save(%Error{} = error) do
    GenServer.cast(__MODULE__, {:save, error})
  end

  def get_all do
    GenServer.call(__MODULE__, :get_all)
  end

  def handle_cast({:save, request}, records) do
    {:noreply, [request | records]}
  end

  def handle_call(:get_all, _from, records) do
    {:reply, records, records}
  end
end
