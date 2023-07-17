export const AVAILABLE_VERSIONS = ["V1", "V2", "V3"];

export const AVAILABLE_CHAINS = [
  "Ethereum",
  "Optimism",
  "Arbitrum",
  "Polygon",
  "Avalanche",
  "Fantom",
  "Harmony",
  "Metis",
];

export const SHORT_CHAINS = {
  Ethereum: "Eth",
  Polygon: "Pol",
  Optimism: "Opt",
  Arbitrum: "Arb",
  Fantom: "Ftm",
  Avalanche: "Ava",
  Metis: "Met",
  Harmony: "Har",
};

export function getDate() {
  const date = new Date();
  const years = date.getFullYear();
  const months = date.getMonth() + 1; // it's js so months are 0 indexed
  const day = date.getDate();
  return `${years}${day <= 9 ? "0" : ""}${day}${
    months <= 9 ? "0" : ""
  }${months}`;
}

export function generateName(options) {
  return `${options.protocolVersion === "v2" ? "AaveV2" : "AaveV3"}_${
    options.chains.length === 1 ? SHORT_CHAINS[options.chains[0]] : "Multi"
  }_${options.topic}_${getDate()}`;
}

export function generateChainName(options, chain) {
  return generateName({ ...options, chains: [chain] });
}

export function getAlias(chain) {
  return chain === "Ethereum" ? "mainnet" : chain.toLowerCase();
}

export function pascalCase(str) {
  return str
    .replace(/(\w)(\w*)/g, function (g0, g1, g2) {
      return g1.toUpperCase() + g2;
    })
    .replace(/ /g, "");
}
