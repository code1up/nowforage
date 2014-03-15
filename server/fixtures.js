if (Items.find().count() === 0) {

    Items.insert({
        name: "Mushrooms",
        description: "Some narrative.",
    });
}
