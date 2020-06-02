require_relative("./dijkstra")

describe "dijkstra" do
    problem = {'A'=> { 'B'=> 2, 'C'=> 7 }, 'B'=> { 'D'=> 1, 'E'=> 8 }, 'C'=> { 'B'=> 3, 'E'=> 12 }, 'D'=> { 'E'=> 4, 'F'=> 9 }, 'E'=> { 'F'=> 4 }, 'F'=> {} }
    it "returns shortest path A to F" do
        shortest = dijkstra(problem, 'A', 'F')
        expect(shortest[:distance]).to eq(11)
        expect(shortest[:path]).to eq(["A", "B", "D", "E", "F"])
    end

    it "returns shortest path B to F" do
        shortest = dijkstra(problem, 'B', 'F')
        expect(shortest[:distance]).to eq(9)
        expect(shortest[:path]).to eq(["B", "D", "E", "F"])
    end

    it "returns Infinity when no path" do
        shortest = dijkstra(problem, 'B', 'A')
        expect(shortest[:distance]).to eq(Float::INFINITY)
        expect(shortest[:path]).to eq([])
    end

    it "returns 0 from a node to itself" do
        shortest = dijkstra(problem, 'B', 'B')
        expect(shortest[:distance]).to eq(0)
        expect(shortest[:path]).to eq(['B'])
    end
end