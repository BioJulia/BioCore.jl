# BioCore.IO
# ======
#
# I/O interfaces for BioJulia packages.
#
# This file is a part of BioJulia.
# License is MIT: https://github.com/BioJulia/BioCore.jl/blob/master/LICENSE.md

module IO

import Compat: @compat

"""
Abstract file format type.

See `subtypes(FileFormat)` for all available file formats.
"""
@compat abstract type FileFormat end

"""
Abstract formatted input/output type.
"""
@compat abstract type AbstractFormattedIO end

"""
    stream(io::AbstractFormattedIO)

Return the underlying `IO` object; subtypes of `AbstractFormattedIO` must
implement this method.
"""
function stream end

# delegate method call
for f in (:eof, :flush, :close)
    @eval function Base.$(f)(io::AbstractFormattedIO)
        return $(f)(stream(io))
    end
end

function Base.open{T<:AbstractFormattedIO}(f::Function, ::Type{T}, args...; kwargs...)
    io = open(T, args...; kwargs...)
    try
        f(io)
    finally
        close(io)
    end
end


"""
Abstract data reader type.

See `subtypes(AbstractReader)` for all available data readers.
"""
@compat abstract type AbstractReader <: AbstractFormattedIO end

Base.iteratorsize{T<:AbstractReader}(::Type{T}) = Base.SizeUnknown()

function Base.open{T<:AbstractReader}(::Type{T}, filepath::AbstractString, args...; kwargs...)
    return T(open(filepath), args...; kwargs...)
end


"""
Abstract data writer type.

See `subtypes(AbstractWriter)` for all available data writers.
"""
@compat abstract type AbstractWriter <: AbstractFormattedIO end

function Base.open{T<:AbstractWriter}(::Type{T}, filepath::AbstractString, args...; kwargs...)
    i = findfirst(kwarg -> kwarg[1] == :append, kwargs)
    if i > 0
        append = kwargs[i][2]
        if !isa(append, Bool)
            throw(ArgumentError("append must be boolean"))
        end
        deleteat!(kwargs, i)
    else
        append = false
    end
    return T(open(filepath, append ? "a" : "w"), args...; kwargs...)
end

# removed function calls
function Base.open{F<:FileFormat}(::AbstractString, ::Type{F})
    error("open(filepath, format) syntax has been removed. Please use open(reader|writer, filepath) instead.")
end

function Base.open{F<:FileFormat}(::AbstractString, ::AbstractString, ::Type{F})
    error("open(filepath, mode, format) syntax has been removed. Please use open(reader|writer, filepath) instead.")
end

end  # module BioCore.IO
