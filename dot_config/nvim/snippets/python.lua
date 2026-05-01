return {
  {
    prefix="cl",
    body=[[
class ${1:ClassName}:

  def __init__(self, ${2:arg}):
    ${0:pass}
    ]],
    desc="Python class with arguments"
  },
}
