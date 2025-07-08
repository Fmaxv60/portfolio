document.addEventListener("DOMContentLoaded", () => {
	const toc = document.getElementById("toc");
	if (!toc) return;

	const headings = document.querySelectorAll(".prose h2, .prose h3, .prose h4, .prose h5, .prose h6");

    if (headings.length === 0) {
        toc.style.display = "none";
        return;
    }

	headings.forEach((heading, index) => {
		const id = heading.id || heading.textContent.trim().toLowerCase().replace(/\s+/g, "-");
		heading.id = id;

		const link = document.createElement("a");
		link.href = `#${id}`;
		link.textContent = heading.textContent;
		link.className = `toc-${heading.tagName.toLowerCase()}`;

		toc.appendChild(link);
	});
});
