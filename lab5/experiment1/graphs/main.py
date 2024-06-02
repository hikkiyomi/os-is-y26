import matplotlib.pyplot as plt


def parse_single(buffer, arr):
    for line in buffer:
        arr.append(float(line))


def parse_double(buffer, mem, swap):
    for i, line in enumerate(buffer):
        if i % 2 == 0:
            mem.append(float(line))
        else:
            swap.append(float(line))


def get_doubled_info(
        filepath_free: str,
        filepath_used: str,
        parse_function,
):
    memory_info = {
        "free": [],
        "used": [],
    }

    swap_info = {
        "free": [],
        "used": [],
    }

    with (
        open(filepath_free, "r") as free,
        open(filepath_used, "r") as used,
    ):
        parse_function(free, memory_info["free"], swap_info["free"])
        parse_function(used, memory_info["used"], swap_info["used"])

    return memory_info, swap_info


def get_single_info(
        filepath_virtual: str,
        filepath_usage: str,
        parse_function,
):
    vm_info = []
    ram_usage_info = []

    with (
        open(filepath_virtual, "r") as virtual,
        open(filepath_usage, "r") as usage,
    ):
        parse_function(virtual, vm_info)
        parse_function(usage, ram_usage_info)

    return vm_info, ram_usage_info


def build_graph(y, ylabel, image_file):
    x = [i for i in range(len(y))]

    plt.xlabel("Seconds passed")
    plt.ylabel(ylabel)
    plt.plot(x, y)
    plt.savefig(image_file)
    plt.clf()


def build_doubled_graph(y1, ylabel1, y2, ylabel2, image_file):
    assert len(y1) == len(y2)

    x = [i for i in range(len(y1))]

    plt.xlabel("Seconds passed")
    plt.plot(x, y1, label=ylabel1)
    plt.plot(x, y2, label=ylabel2)
    plt.legend()
    plt.savefig(image_file)
    plt.clf()


def main():
    log_file = input()

    BASE             = f"../parsed/{log_file}"
    FILEPATH_FREE    = f"{BASE}/memory_swap_free"
    FILEPATH_USED    = f"{BASE}/memory_swap_used"
    FILEPATH_VIRTUAL = f"{BASE}/virtual_memory_used"
    FILEPATH_USAGE   = f"{BASE}/memory_usage_percent"

    memory_info, swap_info = get_doubled_info(FILEPATH_FREE, FILEPATH_USED, parse_double)
    vm_info, ram_usage_info = get_single_info(FILEPATH_VIRTUAL, FILEPATH_USAGE, parse_single)

    build_doubled_graph(
        memory_info["free"],
        "Free memory",
        memory_info["used"],
        "Used memory",
        f"{log_file}/memory.png"
    )

    build_doubled_graph(
        swap_info["free"],
        "Free swap",
        swap_info["used"],
        "Used swap",
        f"{log_file}/swap.png"
    )

    build_graph(vm_info, "Virtual memory", f"{log_file}/vm.png")
    build_graph(ram_usage_info, "RAM%", f"{log_file}/ram.png")


if __name__ == "__main__":
    main()
