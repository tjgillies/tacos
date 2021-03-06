defmodule Tacos.Generators.EctoModel do
  alias Tacos.Encoders.Json

  def run(models) do
    Enum.map(models, &generate_taco/1)
  end

  defp generate_taco(module_name) do
    { model, _ } = Code.eval_string("%#{module_name}{}")

    data = Map.delete(model, :__struct__)
      |> Map.delete(:__meta__)
      |> Json.encode

    model_name = String.split("#{module_name}", ".") |> List.last
    {model_name, data}
  end
end
