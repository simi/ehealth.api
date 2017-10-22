defmodule OtpVerification.Messenger do
  @moduledoc false
  use Mouth.Messenger, otp_app: :otp_verification

  def init do
    config = Confex.get_env(:otp_verification, :mouth)
    {:ok, config}
  end
end
