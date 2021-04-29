defmodule TestcaseWeb.PageLive do
  use TestcaseWeb, :live_view
  alias Phoenix.LiveView.Socket

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url,
    %Socket{assigns: %{live_action: :path_a}} = socket) do
    {:noreply, push_patch(socket, to: Routes.page_path(socket, :path_b))}
  end

  @impl true
  def handle_params(_param, _url, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <%= cond do %>
    <% @live_action == :index -> %>
    <h1>I am index!</h1>
    <%= live_patch "click me", to: Routes.page_path(@socket, :path_a) %>
    <% @live_action == :path_a -> %>
    <h1>I am path a!</h1>
    <% @live_action == :path_b -> %>
    <h1>I am path b!</h1>
    <% end %>
    """
  end
  
end
