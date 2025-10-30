defmodule MyAppWeb.LoginLive do
  use MyAppWeb, :live_view
  

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:form, %{"email" => "", "password" => ""})
      |> assign(:errors, %{})

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", %{"user" => params}, socket) do
    errors = validate(params)
    {:noreply, assign(socket, form: params, errors: errors)}
  end

  @impl true
  def handle_event("save", %{"user" => params}, socket) do
    errors = validate(params)

    if map_size(errors) == 0 do
      # Aquí deberías llamar tu lógica real de autenticación, p. ej. Accounts.authenticate/2
      # Si autenticación ok:
      {:noreply,
       socket
       |> put_flash(:info, "Inicio de sesión correcto (demo). Redirigiendo...")
       |> push_navigate(to: "/dashboard")}
    else
      {:noreply, assign(socket, form: params, errors: errors)}
    end
  end

  # Validación simple para demo
  defp validate(%{"email" => email, "password" => password}) do
    errors = %{}

    errors =
      if String.trim(email) == "" do
        Map.put(errors, :email, "El correo es obligatorio")
      else
        errors
      end

    errors =
      if not String.contains?(email || "", "@") and (email || "") != "" do
        Map.put(errors, :email, "Correo inválido")
      else
        errors
      end

    errors =
      if String.length(password || "") < 6 do
        Map.put(errors, :password, "La contraseña debe tener al menos 6 caracteres")
      else
        errors
      end

    errors
  end
    
    @impl true
  def render(assigns) do
    ~H"""
    <div class="min-h-screen flex items-center justify-center bg-gradient-to-br from-orange-50 to-red-50 px-4">
      <div class="max-w-md w-full">
        <div class="bg-white rounded-2xl shadow-xl p-8">
          <!-- Logo -->
          <div class="flex justify-center mb-8">
            <svg viewBox="0 0 71 48" class="h-12" aria-hidden="true">
              <path
                d="m26.371 33.477-.552-.1c-3.92-.729-6.397-3.1-7.57-6.829-.733-2.324.597-4.035 3.035-4.148 1.995-.092 3.362 1.055 4.57 2.39 1.557 1.72 2.984 3.558 4.514 5.305 2.202 2.515 4.797 4.134 8.347 3.634 3.183-.448 5.958-1.725 8.371-3.828.363-.316.761-.592 1.144-.886l-.241-.284c-2.027.63-4.093.841-6.205.735-3.195-.16-6.24-.828-8.964-2.582-2.486-1.601-4.319-3.746-5.19-6.611-.704-2.315.736-3.934 3.135-3.6.948.133 1.746.56 2.463 1.165.583.493 1.143 1.015 1.738 1.493 2.8 2.25 6.712 2.375 10.265-.068-5.842-.026-9.817-3.24-13.308-7.313-1.366-1.594-2.7-3.216-4.095-4.785-2.698-3.036-5.692-5.71-9.79-6.623C12.8-.623 7.745.14 2.893 2.361 1.926 2.804.997 3.319 0 4.149c.494 0 .763.006 1.032 0 2.446-.064 4.28 1.023 5.602 3.024.962 1.457 1.415 3.104 1.761 4.798.513 2.515.247 5.078.544 7.605.761 6.494 4.08 11.026 10.26 13.346 2.267.852 4.591 1.135 7.172.555Z"
                fill="#FD4F00"
              />
            </svg>
          </div>

          <!-- Title -->
          <div class="text-center mb-8">
            <h1 class="text-3xl font-bold text-gray-900">Welcome Back</h1>
            <p class="text-gray-600 mt-2">Sign in to your account</p>
          </div>

          <!-- Login Form -->
          <form phx-submit="save" phx-change="validate" class="space-y-6">
            <!-- Email Field -->
            <div>
              <label for="user_email" class="block text-sm font-medium text-gray-700 mb-2">
                Email
              </label>
              <input
                type="email"
                name="user[email]"
                id="user_email"
                value={@form["email"]}
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent transition"
                placeholder="Enter your email"
              />
              <%= if @errors[:email] do %>
                <p class="text-red-500 text-xs italic mt-1"><%= @errors[:email] %></p>
              <% end %>
            </div>

            <!-- Password Field -->
            <div>
              <label for="user_password" class="block text-sm font-medium text-gray-700 mb-2">
                Password
              </label>
              <input
                type="password"
                name="user[password]"
                id="user_password"
                value={@form["password"]}
                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-transparent transition"
                placeholder="Enter your password"
              />
              <%= if @errors[:password] do %>
                <p class="text-red-500 text-xs italic mt-1"><%= @errors[:password] %></p>
              <% end %>
            </div>

            <!-- Submit Button -->
            <button
              type="submit"
              class="w-full bg-orange-600 text-white py-3 px-4 rounded-lg font-semibold hover:bg-orange-700 focus:outline-none focus:ring-2 focus:ring-orange-500 focus:ring-offset-2 transition"
            >
              Sign In
            </button>
          </form>
        </div>
      </div>
    </div>
    """
  end
end

