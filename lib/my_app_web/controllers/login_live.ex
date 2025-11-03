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
end
