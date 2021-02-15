using ArgParse

include("./src/harser.jl")

using .harser

settings = ArgParseSettings()

@add_arg_table settings begin
    "--list-users"
    	help= "List Captured users form the HAR"
        action=:store_true
    "--dump", "-d"
    	help="Dump the Context to Local Storage"
        action=:store_true
    "file"
    	help="a HAR file"
        required = true
end

args = parse_args(settings)

try
    init(args["file"])
    if args["list-users"]
        get_users()
    elseif args["dump"]
        dump_all()
    end
catch e
    print("Exception ", e)
end