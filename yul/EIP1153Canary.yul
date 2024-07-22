object "EIP3855Canary" {
    code {
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        return(0, datasize("runtime"))
    }
    object "runtime" {
        code {
            // We don't care about "Solidity" selector, we always run the code
            pop(verbatim_1i_1o(hex"5c", 0))
        }
    }
}
