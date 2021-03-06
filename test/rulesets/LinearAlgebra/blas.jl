@testset "BLAS" begin
    @testset "gemm" begin
        dims = 3:5
        for m in dims, n in dims, p in dims, tA in ('N', 'T'), tB in ('N', 'T')
            α = randn()
            A = randn(tA === 'N' ? (m, n) : (n, m))
            B = randn(tB === 'N' ? (n, p) : (p, n))
            C = gemm(tA, tB, α, A, B)
            ȳ = randn(size(C)...)
            rrule_test(
                gemm,
                ȳ,
                (tA, nothing),
                (tB, nothing),
                (α, randn()),
                (A, randn(size(A))),
                (B, randn(size(B))),
            )
        end
    end
    @testset "gemv" begin
        for n in 3:5, m in 3:5, t in ('N', 'T')
            α = randn()
            A = randn(m, n)
            x = randn(t === 'N' ? n : m)
            y = α * (t === 'N' ? A : A') * x
            ȳ = randn(size(y)...)
            rrule_test(
                gemv,
                ȳ,
                (t, nothing),
                (α, randn()),
                (A, randn(size(A))),
                (x, randn(size(x))),
            )
        end
    end
end
