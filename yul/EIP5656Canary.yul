object "EIP5656Canary" {
    code {
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        return(0, datasize("runtime"))
    }
    object "runtime" {
        code {
            // We don't care about "Solidity" selector, we always run the code
            verbatim_3i_0o(hex"5e", 0, 0, 0)
        }
    }
}
