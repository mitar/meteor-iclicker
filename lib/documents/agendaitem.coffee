counter = (field) ->
  (fields) ->
    [fields._id, fields['field']?.length or 0]

class @AgendaItem extends Document
  # createdAt: time of creation
  # author:
  #   _id: User id
  # actionItem: boolean
  # quorum: number
  # majority: number (0-1, e.g., 0.667 for two-thirds)
  # passAfter: date
  # failAfter: date
  # isOpen: boolean
  # isApproved: boolean
  # body: textId
  # pros: textId
  # cons: textId
  # notes: textId
  # yes: list of
  #  castAt: date
  #  voter:
  #    _id: User id
  # no: list of
  #   castAt: date
  #   voter:
  #     _id: User id
  # abstain: list of
  #   castAt: date
  #   voter:
  #     _id: User id
  #  veto: list of
  #    castAt: date
  #    voter:
  #      _id: User id
  #  yesCount: number
  #  noCount: number
  #  abstainCount: number
  #  vetoCount: number

  @Meta
    name: 'AgendaItem'
    fields: =>
      author: @ReferenceField User
      yes:
        voter: @ReferenceField User
      no:
        voter: @ReferenceField User
      abstain:
        voter: @ReferenceField User
      veto:
        voter: @ReferenceField User
      yesCount: @GeneratedField 'self', ['yes'], counter 'yes'
      noCount: @GeneratedField 'self', ['no'], counter 'no'
      abstainCount: @GeneratedField 'self', ['abstain'], counter 'abstain'
      vetoCount: @GeneratedField 'self', ['veto'], counter 'veto'
