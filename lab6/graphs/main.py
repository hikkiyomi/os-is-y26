import matplotlib.pyplot as plt


def read_info(file):
    arr = []

    with open(file, "r") as f:
        for line in f:
            arr.append(float(line))

    return arr


def build_graph(experiments, title, save_to_path):
    x = [i for i in range(1, 21)]

    plt.title(title)
    plt.xlabel("N")
    plt.ylabel("Seconds")

    for experiment, data in experiments.items():
        plt.plot(x, data, label=experiment)

    plt.legend()
    plt.savefig(save_to_path)
    plt.clf()


def main():
    GROUPS = ["group1", "group2"]
    EXPERIMENTS = ["experiment1", "experiment2", "experiment3", "experiment4"]

    data = {
        group: {
            experiment: read_info(f"../{group}/{experiment}.log")
            for experiment in EXPERIMENTS
        }
        for group in GROUPS
    }

    for group, experiments in data.items():
        build_graph(experiments, group, f"../{group}/graph.png")


if __name__ == "__main__":
    main()
