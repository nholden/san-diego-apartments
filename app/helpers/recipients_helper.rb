module RecipientsHelper
  def subscription_options
    [
      ['No updates', nil],
      ['Immediate updates', 'immediate'],
      ['Daily summary', 'daily'],
      ['Weekly summary', 'weekly'],
    ]
  end
end
